require "application_system_test_case"

module RailsMail
  class EmailsTest < ApplicationSystemTestCase
    fixtures :emails

    setup do
      @email = emails(:one)
    end

    test "visiting the index" do
      visit rails_mail.emails_path

      assert_selector "h1", text: "Rails Mail"
    end

    test "viewing an email" do
      visit rails_mail.emails_path
      click_on @email.subject

      assert_text @email.subject
      assert_text @email.from
      assert_text @email.to.join(", ")
    end
  end
end
