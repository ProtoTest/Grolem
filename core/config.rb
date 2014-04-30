require 'custom_formatter'
require 'j_unit_reporter'

def reset_capybara
  # reset the capybara session and configuration
  Capybara.reset_sessions!

  Capybara.configure do |config|
    config.match = :prefer_exact
    config.exact = false
    config.ignore_hidden_elements = true
    config.visible_text_only = true
    config.default_wait_time = RSpec.configuration.element_wait_sec
  end

  # delete cookies and maximize browser for only desktop browsers
  if (RSpec.configuration.default_browser != Browsers::IPhone) &&
     (RSpec.configuration.default_browser != Browsers::IPad)
    # Delete some cookies for the site that are hanging around
    page.driver.browser.manage.delete_cookie('ewokAuth')
    page.driver.browser.manage.delete_cookie('ewokAuthGuestPass')
    page.driver.browser.manage.delete_cookie('keepLogin')
    page.driver.browser.manage.delete_cookie('is_member')

    # Ensure the browser is maximized to maximize visibility of element
    page.driver.browser.manage.window.maximize

    # Set the page load timeout
    page.driver.browser.manage.timeouts.page_load = Rspec.configuration.page_load_timeout
  end
end

# With implicit waits enabled, use of wait_until methods is no longer required. This method will
# wait for the element to be found on the page until the Capybara default timeout is reached.
SitePrism.configure do |config|
  config.use_implicit_waits = true
end


#### ANY ENVIRONMENT SETUP FROM SHELL ####

# Use remote web driver, default true
ENV['OKL_REMOTE_DRIVER'] ||= "true"

# OKL site sub-domain. Default to qa02 if not set
ENV['OKL_SERVER'] ||= "qa02"

# OKL default browser, default to firefox
ENV['OKL_BROWSER'] ||= "Firefox"

# initialize runtime configuration
browser = Browsers::Firefox
host_platform = :any
host_version = ""
element_wait_sec = 30

case ENV['OKL_BROWSER'].downcase.chomp
  when "firefox" then browser = Browsers::Firefox
  when "chrome" then browser = Browsers::Chrome
  when "safari" then browser = Browsers::Safari
  when "ie" then browser = Browsers::InternetExplorer
  when "android" then browser = Browsers::Android
  when "iphone"
    browser = Browsers::IPhone
    host_platform = :mac
    host_version = "7.0.3" # ios sdk version
    element_wait_sec = 60
  when "ipad"
    browser = Browsers::IPad
    host_platform = :mac
    host_version = "7.0.3" # ios sdk version
    element_wait_sec = 60
end

# if running locally, then put username/password in url, and set host to 'localhost',
# otherwise set the config options to run on OKL grid
if ENV['OKL_REMOTE_DRIVER'].eql?("false")
  default_url = "https://bkitchener:bkitchener123!@#{ENV['OKL_SERVER']}.newokl.com"
  host_ip = "localhost"
  remote_driver = false
else
  default_url = "https://#{ENV['OKL_SERVER']}.newokl.com"
  host_ip = "sfo-qa-grid-hub.corp.onekingslane.biz"
  remote_driver = true
end



#### RSPEC CONFIGURATION ###
RSpec.configure do |config|
  config.include Capybara::DSL
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.add_setting :default_browser, :default => browser
  config.add_setting :remote_driver, :default => remote_driver
  config.add_setting :host_ip, :default => host_ip
  config.add_setting :host_platform, :default=>host_platform
  config.add_setting :host_version, :default=>host_version
  config.add_setting :host_port, :default => 4444
  config.add_setting :page_load_timeout, :default => 30
  config.add_setting :element_wait_sec, :default => element_wait_sec
  config.add_setting :screenshot_on_failure, :default => true
  config.add_setting :command_logging, :default => true
  config.add_setting :default_url, :default => default_url
  config.add_setting :ldap_username, :default => "bkitchener"
  config.add_setting :ldap_user_password, :default =>"bkitchener123!"
  config.add_formatter :documentation,'output.txt'
  config.add_formatter CustomFormatter,'output.html'
  config.add_formatter JUnitReporter,'output.xml'
  config.add_setting :test_name, :default=>'Test'
  config.add_setting :command_delay_sec, :default=>0
  config.add_setting :browsermob_path, :default=>'C:\Users\SethUrban\Documents\GitHub\Grolem\browsermob-proxy\bin\browsermob-proxy.bat'
  config.add_setting :use_proxy, :default=>false
  config.add_setting :proxy_server_port, :default=>8080
  config.add_setting :proxy_port, :default=>9091
  config.add_setting :proxy_host, :default=>'localhost'

  #For some reason this doesn't run before the first test, but runs before all the others
  config.before(:each) do
    $logger = CommandLogger.new
    path = example.metadata[:description]
    config.test_name = path
    $logger.Log "Starting  #{config.test_name}"
    reset_capybara
  end

  config.after(:each) do
    if RSpec.configuration.use_proxy
      har = $proxy.har
      entries = har.entries
      har.save_to (RSpec.configuration.test_name+ '.har')
      $proxy.close
    end
      if example.exception.is_a? Timeout::Error
        # restart Selenium driver
        Capybara.send(:session_pool).delete_if { |key, value| key =~ /selenium/i }
      end
    end

  config.before(:all) do
    if (RSpec.configuration.use_proxy&&RSpec.configuration.default_browser == Browsers::Firefox)
      server = BrowserMob::Proxy::Server.new(RSpec.configuration.browsermob_path) #=> #<BrowserMob::Proxy::Server:0x000001022c6ea8 ...>
      server.start
      $proxy = server.create_proxy
    end
    reset_capybara
    $logger = CommandLogger.new
    $logger.Log "Starting tests on #{RSpec.configuration.default_url}"
    reset_capybara
  end

end



