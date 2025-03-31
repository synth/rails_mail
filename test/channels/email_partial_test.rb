require "test_helper"

module RailsMail
  class EmailPartialTest < ActionCable::Channel::TestCase
    include Engine.routes.url_helpers
    fixtures :emails

    setup do
      @email = emails(:one)
      @email.send(:broadcast_email)
    end

    test "broadcasts the email partial" do
      broadcasted_message = broadcasts("rails_mail:emails").last

      assert_not_nil broadcasted_message, "Expected a broadcasted message but got nil"
      assert_includes broadcasted_message, @email.subject
      assert_includes broadcasted_message, @email.from
      assert_includes broadcasted_message, email_path(@email)
    end
  end
end
