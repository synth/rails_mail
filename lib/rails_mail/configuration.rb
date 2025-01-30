module RailsMail
  class Configuration
    attr_accessor :authentication_callback, :show_clear_button,
                  :trim_emails_older_than, :trim_emails_max_count, :trim_via

    def initialize
      @authentication_callback = nil
      @show_clear_button = nil
      @trim_emails_older_than = nil
      @trim_emails_max_count = nil
      @trim_via = :perform_later
    end

    def trim_via=(value)
      unless [ :perform_now, :perform_later ].include?(value)
        raise ArgumentError, "trim_via must be :now or :later"
      end
      @trim_via = value
    end

    def authentication_callback=(callback)
      unless callback.nil? || callback.respond_to?(:call)
        raise ArgumentError, "authentication_callback must be nil or respond to #call"
      end
      @authentication_callback = callback
    end

    def show_clear_button=(callback)
      unless callback.nil? || callback.respond_to?(:call)
        raise ArgumentError, "show_clear_button must be nil or respond to #call"
      end
      @show_clear_button = callback
    end
  end
end
