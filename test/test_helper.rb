# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [ File.expand_path("../test/dummy/db/migrate", __dir__) ]
require "rails/test_help"
require "minitest/mock"
require "debug"
require_relative "../app/helpers/rails_mail/turbo_helper"

# Register Turbo Stream MIME type
Mime::Type.register "text/vnd.turbo-stream.html", :turbo_stream

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_paths=)
  ActiveSupport::TestCase.fixture_paths = [ File.expand_path("fixtures/rails_mail", __dir__) ]
  ActionDispatch::IntegrationTest.fixture_paths = ActiveSupport::TestCase.fixture_paths
  ActiveSupport::TestCase.file_fixture_path = File.expand_path("fixtures/rails_mail", __dir__)
  ActiveSupport::TestCase.fixtures :all
end

require_relative "support/user_session"
