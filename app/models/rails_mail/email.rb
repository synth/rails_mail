module RailsMail
  class Email < ApplicationRecord
    store_accessor :data, :from, :to, :cc, :bcc, :subject, :body, :content_type, :attachments

    validates :from, presence: true
    validates :to, presence: true

    after_create_commit :broadcast_email
    after_create :schedule_trim_job

    scope :search, ->(query) {
      where("CAST(data AS CHAR) LIKE :q", q: "%#{query}%")
    }

    private

    def broadcast_email
      return unless defined?(::Turbo) && defined?(::ActionCable)

      ::Turbo::StreamsChannel.broadcast_update_to(
        "emails",
        target: "emails",
        partial: "rails_mail/emails/email",
        locals: { email: self }
      )
    rescue NameError => e
      Rails.logger.debug "Skipping broadcast: #{e.message}"
    end

    def schedule_trim_job
      if RailsMail.configuration.sync_via == :now
        RailsMail::TrimEmailsJob.perform_now
      else
        RailsMail::TrimEmailsJob.perform_later
      end
    end
  end
end
