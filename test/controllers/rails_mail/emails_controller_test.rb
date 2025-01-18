require "test_helper"

module RailsMail
  class EmailsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @email = rails_mail_emails(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get emails_url
      assert_response :success
    end

    test "should show email" do
      get email_url(@email)
      assert_response :success
    end
  end
end
