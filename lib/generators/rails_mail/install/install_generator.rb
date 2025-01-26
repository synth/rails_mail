module RailsMail
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def copy_migration
        rake "rails_mail:install:migrations"
      end

      def copy_initializer
        template "initializer.rb", "config/initializers/rails_mail.rb"
      end
    end
  end
end
