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
      if RSpec.configuration.remote_driver
        Capybara::Selenium::Driver.new(app, :browser => get_remote_browser)
      end
      Capybara::Selenium::Driver.new(app, :browser => RSpec.configuration.default_browser)
    end
  end
end