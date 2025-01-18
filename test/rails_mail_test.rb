require "test_helper"

class RailsMailTest < ActiveSupport::TestCase
  class TestMailer < ActionMailer::Base
    default from: "test@example.com"

    def test_email
      mail(
        to: "recipient@example.com",
        cc: "cc@example.com",
        bcc: "bcc@example.com",
        subject: "Test Email"
      ) do |format|
        format.text { render plain: "Hello, World!" }
      end
    end

    def test_email_with_attachment
      attachments["test.txt"] = "test content"
      mail(
        to: "recipient@example.com",
        subject: "Test Email with Attachment"
      ) do |format|
        format.text { render plain: "Email with attachment" }
      end
    end

    def invalid_email
      mail(
        from: nil,
        to: "recipient@example.com",
        subject: "Test Email"
      ) do |format|
        format.text { render plain: "Invalid email" }
      end
    end
  end

  def setup
    @delivery_method = RailsMail::DeliveryMethod.new
    ActionMailer::Base.delivery_method = :rails_mail
  end

  test "it has a version number" do
    assert RailsMail::VERSION
  end

  test "delivery method creates an email record" do
    assert_difference "RailsMail::Email.count" do
      TestMailer.test_email.deliver_now
    end
  end

  test "stored email has correct attributes" do
    TestMailer.test_email.deliver_now
    email = RailsMail::Email.last

    assert_equal "test@example.com", email.from
    assert_equal [ "recipient@example.com" ], email.to
    assert_equal [ "cc@example.com" ], email.cc
    assert_equal [ "bcc@example.com" ], email.bcc
    assert_equal "Test Email", email.subject
    assert_includes email.body, "Hello, World!"
  end

  test "delivery method handles attachments" do
    TestMailer.test_email_with_attachment.deliver_now
    email = RailsMail::Email.last

    assert_equal 1, email.attachments.size
    assert_equal "test.txt", email.attachments.first["filename"]
    assert_match %r{^text/plain}, email.attachments.first["content_type"]
  end

  test "delivery method raises error on invalid email" do
    assert_raises ActiveRecord::RecordInvalid do
      TestMailer.invalid_email.deliver_now
    end
  end
end
