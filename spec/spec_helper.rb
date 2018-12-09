require 'bundler/setup'
require 'dotenv/load'

require 'kakuyomu_agent'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def driver
    options = Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
    Selenium::WebDriver.for(:chrome, options: options)
  end
end
