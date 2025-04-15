require "rails_mail/version"
require "rails_mail/engine"
require "rails_mail/delivery_method"
require "rails_mail/configuration"
require "rails_mail/exception_parser"
require "rails_mail/renderer"

module RailsMail
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def reset_configuration!
      @configuration = Configuration.new
    end

    def authentication_callback
      configuration.authentication_callback || ->(request) { true }
    end

    def show_clear_all_button_callback
      configuration.show_clear_all_button || ->(request) { true }
    end
  end
end
