module RailsMail
  module TurboHelper
    def turbo_frame_tag(name, src: nil, &block)
      tag.turbo_frame id: name, src: src do
        if block_given?
          yield
        end
      end
    end
  end
end
