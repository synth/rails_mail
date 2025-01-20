module RailsMail
  class Email < ApplicationRecord
    store_accessor :data, :from, :to, :cc, :bcc, :subject, :body, :content_type, :attachments

    validates :from, presence: true
    validates :to, presence: true
    validates :subject, presence: true

    after_create_commit :broadcast_email

    private

    def broadcast_email
      return unless defined?(::Turbo)

      ::Turbo::StreamsChannel.broadcast_update_to(
        "emails",
        target: "emails",
        partial: "rails_mail/emails/email",
        locals: { email: self }
      )
    end
  end
end
