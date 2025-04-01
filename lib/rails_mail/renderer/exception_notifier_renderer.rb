module RailsMail
  module Renderer
    class ExceptionNotifierRenderer < Base
      def self.handles?(email)
        email.exception_parser.valid_format?
      end

      def self.partial_name
        "rails_mail/emails/exception"
      end

      def self.title
        "Exception"
      end

      def self.priority
        1 # After standard renderers
      end

      def self.data(email)
        { exception: email.exception_parser.parse }
      end
    end
  end
end
