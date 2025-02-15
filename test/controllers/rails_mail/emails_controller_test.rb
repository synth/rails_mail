require "test_helper"

module RailsMail
  class EmailsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include ActionView::RecordIdentifier

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

    test "should destroy all emails" do
      assert RailsMail::Email.count > 0, "Should have emails to destroy"

      delete destroy_all_emails_url

      assert_redirected_to emails_path
      assert_equal 0, RailsMail::Email.count
    end

    test "should destroy all emails with turbo stream format" do
      assert RailsMail::Email.count > 0, "Should have emails to destroy"

      delete destroy_all_emails_url, headers: {
        Accept: "text/vnd.turbo-stream.html, text/html, application/json"
      }

      assert_response :success
      assert_equal 0, RailsMail::Email.count
      assert_match /<turbo-stream/, @response.body
      assert_match /email-sidebar/, @response.body
      assert_match /email_content/, @response.body
    end

    test "should destroy email with turbo stream format" do
      assert_difference "RailsMail::Email.count", -1 do
        delete email_url(@email), headers: {
          Accept: "text/vnd.turbo-stream.html"
        }
      end

      assert_response :success
      assert_match /<turbo-stream action="remove"/, @response.body
      assert_match /#{dom_id(@email)}/, @response.body
    end
  end
end
