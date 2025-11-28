module RailsMail
  module Renderer
    class HtmlRenderer < Base
      def self.handles?(email)
        email.html_part.present?
      end

      def self.partial_name
        "rails_mail/emails/html_content"
      end

      def self.title
        "HTML"
      end

      def self.priority
        10 # Base priority for standard content
      end
    end
  end
end
