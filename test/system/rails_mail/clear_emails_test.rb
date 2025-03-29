require "application_system_test_case"

module RailsMail
  class ClearEmailsTest < ApplicationSystemTestCase
    include UserSession
    fixtures :emails

    test "clearing all emails" do
      visit rails_mail.emails_path

      # Verify emails exist before clearing
      assert_selector ".email-row", count: 3

      # Click the clear button and confirm the action
      accept_confirm do
        click_button "Clear"
      end

      # Verify emails are removed
      assert_selector ".email-row", count: 0
      assert_text "No emails have been sent"
      assert ActionMailer::Base.deliveries.empty?
    end

    teardown do
      ActionMailer::Base.deliveries.clear
    end
  end
end
