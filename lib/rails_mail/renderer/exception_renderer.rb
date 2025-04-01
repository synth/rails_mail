module RailsMail
  module Renderer
    class ExceptionRenderer < Base
      def self.handles?(email)
        email.exception_parser.valid_format?
      end

      def self.partial_name
        "rails_mail/emails/exception"
      end

      def self.priority
        10 # Render after standard renderers
      end

      def self.data(email)
        { exception: email.exception_parser.parse }
      end
    end
  end
end
