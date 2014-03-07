
module Browsers
  Firefox = :firefox
  Chrome = :chrome
  Safari = :safari
  InternetExplorer = :ie
  Android = :android
  IOS = :iphone
  MockPhone = :mockphone
  MockTablet = :mocktablet



    puts "SetDefaultBrowser"
    Capybara.register_driver :selenium do |app|
      if RSpec.configuration.remote_driver
        Capybara::Selenium::Driver.new(app, :browser => GetRemoteBrowser())
      end
      Capybara::Selenium::Driver.new(app, :browser => RSpec.configuration.default_browser)
    end


  def GetRemoteBrowser
    Selenium::WebDriver.for(:remote, :desired_capabilities => RSpec.configuration.default_browser)
  end

end