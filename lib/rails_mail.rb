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
      @authentication_callback || -> { true }
    end
  end

  class Configuration
    def authentication_callback(&block)
      RailsMail.authentication_callback(&block)
    end
  end
end
