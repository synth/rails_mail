module RailsMail
  module Renderer
    class Base
      def self.handles?(email)
        raise NotImplementedError, "#{self.name} must implement .handles?"
      end

      def self.partial_name
        raise NotImplementedError, "#{self.name} must implement .partial_name"
      end

      def self.title
        self.name.demodulize.sub("Renderer", "")
      end

      def self.priority
        0 # Lower numbers render first
      end

      def self.data(email)
        {} # Override to provide additional data to the partial
      end
    end
  end
end
