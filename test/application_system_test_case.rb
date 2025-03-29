require "test_helper"
require "capybara/rails"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [ 1400, 1400 ], options: {
    options: Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      user_data_dir = File.join(Dir.tmpdir, "selenium", "user_data_#{SecureRandom.hex(8)}")
      opts.add_argument("--user-data-dir=#{user_data_dir}")
    end
  }
end
