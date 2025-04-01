module RailsMail
  module Renderer
    class TextRenderer < Base
      def self.handles?(email)
        email.content_type&.include?("text/plain") ||
          email.content_type&.include?("multipart/alternative")
      end

      def self.partial_name
        "rails_mail/emails/text_content"
      end

      def self.title
        "Text"
      end

      def self.priority
        1 # Just after HTML
      end
    end
  end
end
