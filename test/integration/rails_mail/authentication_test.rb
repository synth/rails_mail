require "test_helper"

module RailsMail
  class AuthenticationTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
      @email = rails_mail_emails(:one)
    end

    test "allows access when no authentication callback is configured" do
      get emails_url
      assert_response :success
    end

    test "allows access when authentication callback returns true" do
      RailsMail.configure do |config|
        config.authentication_callback do
          true
        end
      end

      get emails_url
      assert_response :success
    end

    test "denies access when authentication callback raises error" do
      RailsMail.configure do |config|
        config.authentication_callback do
          raise ActionController::RoutingError.new("Not Found")
        end
      end

      assert_response get(emails_url), 404
    end

    test "handles authlogic-style authentication when admin" do
      mock_user = Object.new
      def mock_user.admin?; true; end

      mock_user_session = Object.new
      def mock_user_session.user; @user; end
      mock_user_session.instance_variable_set(:@user, mock_user)

      UserSession.stub :find, mock_user_session do
        RailsMail.configure do |config|
          config.authentication_callback do
            user_session = UserSession.find
            msg = Rails.env.development? ? "Forbidden" : "Not Found"
            raise ActionController::RoutingError.new(msg) unless user_session&.user&.admin?
          end
        end

        get emails_url
        assert_response :success
      end
    end

    test "denies access with authlogic when user is not admin" do
      mock_user = Object.new
      def mock_user.admin?; false; end

      mock_user_session = Object.new
      def mock_user_session.user; @user; end
      mock_user_session.instance_variable_set(:@user, mock_user)

      UserSession.stub :find, mock_user_session do
        RailsMail.configure do |config|
          config.authentication_callback do
            user_session = UserSession.find
            msg = Rails.env.development? ? "Forbidden" : "Not Found"
            raise ActionController::RoutingError.new(msg) unless user_session&.user&.admin?
          end
        end

        assert_response get(emails_url), 404
      end
    end

    test "denies access with authlogic when no user session exists" do
      UserSession.stub :find, nil do
        RailsMail.configure do |config|
          config.authentication_callback do
            user_session = UserSession.find
            msg = Rails.env.development? ? "Forbidden" : "Not Found"
            raise ActionController::RoutingError.new(msg) unless user_session&.user&.admin?
          end
        end

        assert_response get(emails_url), 404
      end
    end

    teardown do
      # Reset the authentication callback after each test
      RailsMail.configure do |config|
        config.authentication_callback do
          true
        end
      end
    end
  end
end
