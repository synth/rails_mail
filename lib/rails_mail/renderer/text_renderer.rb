module RailsMail
  module Renderer
    class TextRenderer < Base
      def self.handles?(email)
        email.text_part.present?
      end

      def self.partial_name
        "rails_mail/emails/text_content"
      end

      def self.title
        "Text"
      end

      def self.priority
        20 # Just after HTML
      end
    end
  end
end
