require "application_system_test_case"

module RailsMail
  class EmailsTest < ApplicationSystemTestCase
    setup do
      @email = rails_mail_emails(:one)
    end

    test "visiting the index" do
      visit emails_url
      assert_selector "h1", text: "RailsMail"
    end

    test "viewing an email" do
      visit emails_url
      click_on @email.subject

      assert_text @email.subject
      assert_text @email.from
      assert_text @email.to.join(", ")
    end
  end
end
