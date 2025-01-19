module RailsMail
  class Email < ApplicationRecord
    store_accessor :data, :from, :to, :cc, :bcc, :subject, :body, :content_type, :attachments

    validates :from, presence: true
    validates :to, presence: true
    validates :subject, presence: true
  end
end
