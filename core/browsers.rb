module Browsers
  Firefox = :firefox
  Chrome = :chrome
  Safari = :safari
  InternetExplorer = :ie
  Android = :android
  IPhone = :iphone
  IPad = :ipad

  #:browser_name          => "",
  #    :version               => "",
  #    :platform              => :any,
  #    :javascript_enabled    => false,
  #:css_selectors_enabled => false,
  #:takes_screenshot      => false,
  #:native_events         => false,
  #:rotatable             => false,
  #:firefox_profile       => nil,
  #:proxy                 => nil
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
        case RSpec.configuration.default_browser
          when :firefox
            capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(:platform=>RSpec.configuration.host_platform, :version=>RSpec.configuration.host_version,:url=>RSpec.configuration.host_ip)
          when :chrome
            capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(:platform=>RSpec.configuration.host_platform, :version=>RSpec.configuration.host_version,:url=>RSpec.configuration.host_ip)
          when :safari
            capabilities = Selenium::WebDriver::Remote::Capabilities.safari(:platform=>RSpec.configuration.host_platform, :version=>RSpec.configuration.host_version,:url=>RSpec.configuration.host_ip)
          when :ie
            capabilities = Selenium::WebDriver::Remote::Capabilities.ie(:platform=>RSpec.configuration.host_platform, :version=>RSpec.configuration.host_version,:url=>RSpec.configuration.host_ip)
          when :iphone
            capabilities = Selenium::WebDriver::Remote::Capabilities.iphone(:platform=>RSpec.configuration.host_platform, :version=>RSpec.configuration.host_version,:url=>RSpec.configuration.host_ip,:app=>RSpec.configuration.app_name)
          when :ipad
            capabilities = Selenium::WebDriver::Remote::Capabilities.ipad(:platform=>RSpec.configuration.host_platform, :version=>RSpec.configuration.host_version,:url=>RSpec.configuration.host_ip, :app=>RSpec.configuration.app_name)
          else
            capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(:platform=>RSpec.configuration.host_platform, :version=>RSpec.configuration.host_version,:url=>RSpec.configuration.host_ip)
        end
        driver = Capybara::Selenium::Driver.new(app,
                                       :browser => :remote,
                                       :desired_capabilities => capabilities)
      end
      driver
    end
  end
end