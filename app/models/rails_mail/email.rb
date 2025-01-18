module RailsMail
  class Email < ApplicationRecord
    serialize :to, Array
    serialize :cc, Array
    serialize :bcc, Array
    serialize :attachments, Array
  end
end 