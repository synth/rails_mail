module RailsMail
  module TurboHelper
    def turbo_frame_tag(name, &block)
      tag.div id: name, data: { turbo_frame: true }, &block
    end
  end
end
