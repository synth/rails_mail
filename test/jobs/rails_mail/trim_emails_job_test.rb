require 'test_helper'

module RailsMail
  class TrimEmailsJobTest < ActiveJob::TestCase
    setup do
      @old_config = {
        trim_emails_older_than: RailsMail.configuration.trim_emails_older_than,
        trim_emails_max_count: RailsMail.configuration.trim_emails_max_count
      }
    end

    teardown do
      RailsMail.configuration.trim_emails_older_than = @old_config[:trim_emails_older_than]
      RailsMail.configuration.trim_emails_max_count = @old_config[:trim_emails_max_count]
    end

    def create_email(from: 'test1@example.com', to: 'test2@example.com', subject: 'test', created_at: 12.hours.ago)
      RailsMail::Email.create!(from: from, to: to, subject: subject, created_at: created_at)
    end

    test "trims by age" do
      RailsMail.configuration.trim_emails_older_than = 1.day
      
      old_email = create_email(created_at: 2.days.ago)
      new_email = create_email(created_at: 12.hours.ago)

      assert_difference 'RailsMail::Email.count', -1 do
        RailsMail::TrimEmailsJob.perform_now
      end

      assert_not RailsMail::Email.exists?(old_email.id)
      assert RailsMail::Email.exists?(new_email.id)
    end

    test "trims by count" do
      RailsMail.configuration.trim_emails_max_count = 2

      RailsMail::Email.delete_all # sanity check, clear the table

      emails = 4.times.map { create_email }

      assert_difference 'RailsMail::Email.count', -2 do
        RailsMail::TrimEmailsJob.perform_now
      end

      assert RailsMail::Email.exists?(emails.last.id)
      assert RailsMail::Email.exists?(emails[-2].id)
      assert_not RailsMail::Email.exists?(emails.first.id)
      assert_not RailsMail::Email.exists?(emails[1].id)
    end

    test "trims by both age and count" do
      RailsMail.configuration.trim_emails_older_than = 1.day
      RailsMail.configuration.trim_emails_max_count = 2

      RailsMail::Email.delete_all # sanity check, clear the table
      old_emails = 2.times.map { create_email(created_at: 2.days.ago) }
      new_emails = 3.times.map { create_email(created_at: 12.hours.ago) }

      assert_difference 'RailsMail::Email.count', -3 do
        RailsMail::TrimEmailsJob.perform_now
      end

      old_emails.each { |email| assert_not RailsMail::Email.exists?(email.id) }
      assert_not RailsMail::Email.exists?(new_emails.first.id)
      assert RailsMail::Email.exists?(new_emails[-1].id)
      assert RailsMail::Email.exists?(new_emails[-2].id)
    end
  end
end 