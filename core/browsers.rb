module Browsers
  Firefox = :firefox
  Chrome = :chrome
  Safari = :safari
  InternetExplorer = :ie
  Android = :android
  IOS = :iphone
  MockPhone = :mockphone
  MockTablet = :mocktablet


  def get_remote_browser
    Selenium::WebDriver.for(:remote, :desired_capabilities => RSpec.configuration.default_browser)
  end

  def setup_browser
    $logger.Log "SetDefaultBrowser: #{RSpec.configuration.default_browser}"
    Capybara.register_driver :selenium do |app|
      if RSpec.configuration.use_proxy
        profile = Selenium::WebDriver::Firefox::Profile.new
        profile.proxy = $proxy.selenium_proxy
        $proxy.new_har RSpec.configuration.test_name
        profile = Selenium::WebDriver::Firefox::Profile.new
        profile["network.proxy.type"] = 1 # manual proxy config
        profile["network.proxy.http"] = RSpec.configuration.proxy_host
        profile["network.proxy.http_port"] = RSpec.configuration.proxy_port
        driver = Capybara::Selenium::Driver.new(app,  :browser => RSpec.configuration.default_browser,:profile => profile)
      else driver = Capybara::Selenium::Driver.new(app, :browser => RSpec.configuration.default_browser)
      end
      if RSpec.configuration.remote_driver
        driver = Capybara::Selenium::Driver.new(app, :browser => get_remote_browser)
      end
      driver
    end
  end
end