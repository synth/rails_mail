module RailsMail
  class EmailsChannel < ApplicationCable::Channel
    def subscribed
      stream_from "rails_mail:emails"
    end
  end
end
