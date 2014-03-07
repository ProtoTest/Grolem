puts "Setting config"
RSpec.configure do |config|
  config.include Capybara::DSL
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.add_setting :default_browser, :default => Browsers::Chrome;
  config.add_setting :remote_driver, :default => false
  config.add_setting :host_ip, :default => "localhost"
  config.add_setting :element_wait_sec, :default => 5
  config.add_setting :screenshot_on_failure, :default => true
  config.add_setting :command_logging, :default => true
  config.add_setting :mock_mobile, :default =>true
  config.add_setting :default_url, :default => "http://www.onekingslane.com"
end


def get_remote_browser
  Selenium::WebDriver.for(:remote, :desired_capabilities => RSpec.configuration.default_browser)
end

def setup_browser
  puts "SetDefaultBrowser: #{RSpec.configuration.default_browser}"
  Capybara.register_driver :selenium do |app|
    if RSpec.configuration.remote_driver
      Capybara::Selenium::Driver.new(app, :browser => get_remote_browser)
    end
    Capybara::Selenium::Driver.new(app, :browser => RSpec.configuration.default_browser)
  end
end

