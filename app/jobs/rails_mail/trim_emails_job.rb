module RailsMail
  class TrimEmailsJob < ApplicationJob
    queue_as :default

    def perform
      return unless should_trim?

      if RailsMail.configuration.trim_emails_older_than
        trim_by_age
      end

      if RailsMail.configuration.trim_emails_max_count
        trim_by_count
      end
    end

    private

    def should_trim?
      RailsMail.configuration.trim_emails_older_than.present? ||
        RailsMail.configuration.trim_emails_max_count.present?
    end

    def trim_by_age
      cutoff_date = RailsMail.configuration.trim_emails_older_than.ago
      RailsMail::Email.where('created_at < ?', cutoff_date).destroy_all
    end

    def trim_by_count
      max_count = RailsMail.configuration.trim_emails_max_count
      return unless max_count.positive?

      emails_to_delete = RailsMail::Email
        .order(created_at: :desc)
        .offset(max_count)
      
      emails_to_delete.destroy_all
    end
  end
end 