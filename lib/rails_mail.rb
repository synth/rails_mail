require "rails_mail/version"
require "rails_mail/engine"
require "rails_mail/delivery_method"

module RailsMail
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def authentication_callback(&block)
      @authentication_callback = block if block
      @authentication_callback || ->(request) { true }
    end

    def show_clear_button?(&block)
      @show_clear_button = block if block
      @show_clear_button || ->(request) { true }
    end
  end

  class Configuration
    def authentication_callback(&block)
      RailsMail.authentication_callback(&block)
    end

    def show_clear_button(&block)
      RailsMail.show_clear_button?(&block)
    end
  end
end
