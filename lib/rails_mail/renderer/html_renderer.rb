module RailsMail
  module Renderer
    class HtmlRenderer < Base
      def self.handles?(email)
        email.content_type&.include?("text/html") ||
          email.content_type&.include?("multipart/alternative")
      end

      def self.partial_name
        "rails_mail/emails/html_content"
      end

      def self.title
        "HTML"
      end

      def self.priority
        0 # Base priority for standard content
      end
    end
  end
end
