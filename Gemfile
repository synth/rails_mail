source "https://rubygems.org"

# Specify your gem's dependencies in rails_mail.gemspec.
gemspec

gem "puma"

gem "sqlite3"

gem "propshaft"

# Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
gem "rubocop-rails-omakase", require: false

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"

group :test do
  gem "actioncable"
  gem "turbo-rails"
end

group :test, :system_test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
