module RailsMail
  module TurboHelper

    def rails_mail_turbo_stream_from(*streamables, **attributes)
      return unless defined?(::ActionCable)

      raise ArgumentError, "streamables can't be blank" unless streamables.any?(&:present?)
      attributes[:channel] = attributes[:channel]&.to_s || "Turbo::StreamsChannel"
      # attributes[:"signed-stream-name"] = Turbo::StreamsChannel.signed_stream_name(streamables)

      tag.turbo_cable_stream_source(**attributes)
    end

    def rails_mail_turbo_stream
      TurboStreamBuilder.new
    end

    class TurboStreamBuilder
      def append(target:, content:)
        build_stream("append", target, content)
      end

      def prepend(target:, content:)
        build_stream("prepend", target, content)
      end

      def update(target:, content:)
        build_stream("update", target, content)
      end

      private

      def build_stream(action, target, content)
        %(<turbo-stream action="#{action}" target="#{target}"><template>#{content}</template></turbo-stream>)
      end
    end
  end
end
