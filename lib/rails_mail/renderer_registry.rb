module RailsMail
  class RendererRegistry
    class << self
      def register(renderer_class)
        renderers << renderer_class
      end

      def renderers
        @renderers ||= []
      end

      def matching_renderers(email)
        renderers
          .select { |renderer| renderer.handles?(email) }
          .sort_by(&:priority)
      end
    end
  end
end
