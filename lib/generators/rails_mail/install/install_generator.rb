module RailsMail
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("templates", __dir__)

      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      def create_migration
        migration_template(
          "create_rails_mail_emails.rb",
          "db/migrate/create_rails_mail_emails.rb"
        )
      end
    end
  end
end 