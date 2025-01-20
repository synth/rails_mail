module RailsMail
  module TurboHelper
    def turbo_frame_tag(name, src: nil, &block)
      tag.turbo_frame id: name, src: src do
        if block_given?
          yield
        end
      end
    end

    def turbo_stream_from(*streamables, **attributes)
      raise ArgumentError, "streamables can't be blank" unless streamables.any?(&:present?)
      attributes[:channel] = attributes[:channel]&.to_s || "Turbo::StreamsChannel"
      # attributes[:"signed-stream-name"] = Turbo::StreamsChannel.signed_stream_name(streamables)

      tag.turbo_cable_stream_source(**attributes)
    end

    def turbo_stream
      TurboStreamBuilder.new
    end

    class TurboStreamBuilder
      def append(target:, content:)
        build_stream("append", target, content)
      end

      def prepend(target:, content:)
        build_stream("prepend", target, content)
      end

      private

      def build_stream(action, target, content)
        %(<turbo-stream action="#{action}" target="#{target}"><template>#{content}</template></turbo-stream>)
      end
    end
  end
end
