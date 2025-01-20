module RailsMail
  class Email < ApplicationRecord
    store_accessor :data, :from, :to, :cc, :bcc, :subject, :body, :content_type, :attachments

    validates :from, presence: true
    validates :to, presence: true
    validates :subject, presence: true

    after_create_commit :broadcast_email

    private

    def broadcast_email
      Turbo::StreamsChannel.broadcast_prepend_to(
        "rails_mail:emails",
        target: "emails-list",
        partial: "rails_mail/shared/email",
        locals: { email: self }
      )
    end
  end
end
