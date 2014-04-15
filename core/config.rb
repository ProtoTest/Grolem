require 'custom_formatter'

def reset_capybara
  # reset the capybara session and configuration
  Capybara.reset_sessions!
  Capybara.reset!

  Capybara.configure do |config|
    config.match = :prefer_exact
    config.exact = false
    config.ignore_hidden_elements = true
    config.visible_text_only = true
  end



  # Delete some cookies for the site that are hanging around
  page.driver.browser.manage.delete_cookie('ewokAuth')
  page.driver.browser.manage.delete_cookie('ewokAuthGuestPass')
  page.driver.browser.manage.delete_cookie('keepLogin')
  page.driver.browser.manage.delete_cookie('is_member')

  # Ensure the browser is maximized to maximize visibility of element
  page.driver.browser.manage.window.maximize

  # With implicit waits enabled, use of wait_until methods is no longer required. This method will
  # wait for the element to be found on the page until the Capybara default timeout is reached.
  SitePrism.configure do |config|
    config.use_implicit_waits = true
  end
end

RSpec.configure do |config|
  config.include Capybara::DSL
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.add_setting :default_browser, :default => Browsers::Firefox
  config.add_setting :remote_driver, :default => false
  config.add_setting :host_ip, :default => "localhost"
  config.add_setting :host_platform, :default=>:any
  config.add_setting :host_version, :default=>""
  config.add_setting :element_wait_sec, :default => 5
  config.add_setting :screenshot_on_failure, :default => true
  config.add_setting :command_logging, :default => true
  config.add_setting :mock_mobile, :default =>true
  config.add_setting :default_url, :default => "https://bkitchener:bkitchener123!@qa02.newokl.com"
  config.add_setting :ldap_username, :default => "bkitchener"
  config.add_setting :ldap_user_password, :default =>"bkitchener123!"
  config.add_formatter :documentation,'output.txt'
  config.add_formatter CustomFormatter,'output.html'
  config.add_setting :test_name, :default=>'Test'
  config.add_setting :command_delay_sec, :default=>0
  config.add_setting :browsermob_path, :default=>'C:\Users\Brian\Documents\GitHub\Grolem\browsermob-proxy\bin\browsermob-proxy.bat'
  config.add_setting :use_proxy, :default=>false
  config.add_setting :proxy_server_port, :default=>8080
  config.add_setting :proxy_port, :default=>9091
  config.add_setting :proxy_host, :default=>'localhost'

  config.before(:all) do
    if (RSpec.configuration.use_proxy&&RSpec.configuration.default_browser == Browsers::Firefox)
      server = BrowserMob::Proxy::Server.new(RSpec.configuration.browsermob_path) #=> #<BrowserMob::Proxy::Server:0x000001022c6ea8 ...>
      server.start
      $proxy = server.create_proxy
    end
    $logger = CommandLogger.new
  end

  config.after(:all) do

  end

  config.before(:each) do
    $logger = CommandLogger.new
    path = example.metadata[:description]
    config.test_name = path
    reset_capybara
  end

  config.after(:each) do
    if RSpec.configuration.use_proxy
      har = $proxy.har
      entries = har.entries
      har.save_to (RSpec.configuration.test_name+ '.har')
      $proxy.close
    end
  end
end



