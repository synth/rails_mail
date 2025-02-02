module RailsMail
  class Email < ApplicationRecord
    store_accessor :data, :from, :to, :cc, :bcc, :subject, :body, :content_type, :attachments

    validates :from, presence: true
    validates :to, presence: true

    after_create_commit :broadcast_email
    after_create_commit :schedule_trim_job

    scope :search, ->(query) {
      where("CAST(data AS CHAR) LIKE :q", q: "%#{query}%")
    }

    def text?
      content_type&.include?("text/plain")
    end

    def html?
      content_type&.include?("text/html")
    end
    private

    def broadcast_email
      return unless defined?(::Turbo) && defined?(::ActionCable)

      ::Turbo::StreamsChannel.broadcast_prepend_to(
        "rails_mail:emails",
        target: "email-sidebar",
        partial: "rails_mail/shared/email",
        locals: { email: self }
      )
    rescue StandardError => e
      Rails.logger.error "RailsMail::Email#broadcast_email failed: #{e.message}"
    end

    def schedule_trim_job
      if RailsMail.configuration.trim_via == :perform_now
        RailsMail::TrimEmailsJob.perform_now
      else
        RailsMail::TrimEmailsJob.perform_later
      end
    rescue StandardError => e
      Rails.logger.error "RailsMail::Email#schedule_trim_job Failed: #{e.message}"
    end
  end
end
