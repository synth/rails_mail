module RailsMail
  class FrontendsController < ActionController::Base # rubocop:disable Rails/ApplicationController
    STATIC_ASSETS = {
      css: {
        # tailwind: RailsMail::Engine.root.join("app", "frontend", "rails_mail", "vendor", "tailwind", "tailwind.min.css"),
        style: RailsMail::Engine.root.join("app", "frontend", "rails_mail", "style.css")
      },
      js: {
        tailwind: RailsMail::Engine.root.join("app", "frontend", "rails_mail", "vendor", "tailwind", "tailwind.min.js")
      },
      png: {
        rails_mail_logo: RailsMail::Engine.root.join("app", "assets", "images", "rails_mail", "rails-mail.png")
      }
    }.freeze

    # Additional JS modules that don't live in app/frontend/rails_mail/modules
    MODULE_OVERRIDES = {
      application: RailsMail::Engine.root.join("app", "frontend", "rails_mail", "application.js"),
      stimulus: RailsMail::Engine.root.join("app", "frontend", "rails_mail", "vendor", "stimulus.js"),
      turbo: RailsMail::Engine.root.join("app", "frontend", "rails_mail", "vendor", "turbo.js"),
      action_cable: RailsMail::Engine.root.join("app", "frontend", "rails_mail", "vendor", "action_cable.js"),
      "date-fns": RailsMail::Engine.root.join("app", "frontend", "rails_mail", "vendor", "date-fns.js")
    }.freeze

    def self.js_modules
      if Rails.env.production?
        @_js_modules ||= load_js_modules
      else
        load_js_modules
      end
    end

    def self.load_js_modules
      RailsMail::Engine.root.join("app", "frontend", "rails_mail", "modules").children.select(&:file?).each_with_object({}) do |file, modules|
        key = File.basename(file.basename.to_s, ".js").to_sym
        modules[key] = file
      end.merge(MODULE_OVERRIDES)
    end

    # Necessarly to serve Javascript to the browser
    skip_after_action :verify_same_origin_request, raise: false
    before_action { expires_in 1.year, public: true }

    def static
      render file: STATIC_ASSETS.dig(params[:format].to_sym, params[:name].to_sym) || raise(ActionController::RoutingError, "Not Found")
    end

    def module
      raise(ActionController::RoutingError, "Not Found") if params[:format] != "js"

      render file: self.class.js_modules[params[:name].to_sym] || raise(ActionController::RoutingError, "Not Found")
    end
  end
end
