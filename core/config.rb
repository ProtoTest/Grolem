require 'custom_formatter'
require 'j_unit_reporter'


Capybara.configure do |config|
  config.match = :prefer_exact
  config.exact = false
  config.ignore_hidden_elements = true
  config.visible_text_only = true
end

# With implicit waits enabled, use of wait_until methods is no longer required. This method will
# wait for the element to be found on the page until the Capybara default timeout is reached.
SitePrism.configure do |config|
  config.use_implicit_waits = true
end

RSpec.configure do |config|
  config.include Capybara::DSL
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.add_setting :default_browser, :default => Browsers::Firefox
  config.add_setting :remote_driver, :default => false
  config.add_setting :host_ip, :default => "localhost"
  config.add_setting :host_platform, :default=>:any
  config.add_setting :host_version, :default=>""
  config.add_setting :app_name, :default=>""
  config.add_setting :element_wait_sec, :default => 5
  config.add_setting :screenshot_on_failure, :default => true
  config.add_setting :command_logging, :default => true
  config.add_setting :mock_mobile, :default =>true
  config.add_setting :default_url, :default => "https://bkitchener:bkitchener123!@qa02.newokl.com"
  config.add_setting :ldap_username, :default => "bkitchener"
  config.add_setting :ldap_user_password, :default =>"bkitchener123!"
  config.add_formatter :documentation,'output.txt'
  config.add_formatter CustomFormatter,'output.html'
  config.add_formatter JUnitReporter, 'output.xml'
  config.add_setting :test_name, :default=>'Test'
  config.add_setting :command_delay_sec, :default=>0
  config.add_setting :browsermob_path, :default=>'C:\Users\SethUrban\Documents\GitHub\Grolem\browsermob-proxy\bin\browsermob-proxy.bat'
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


include Browsers
Capybara.default_driver = :selenium
Capybara.app_host = RSpec.configuration.default_url
Capybara.default_wait_time = RSpec.configuration.element_wait_sec
Capybara.run_server = false;

Capybara::Screenshot.append_timestamp = false
Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  "screenshot_" + RSpec.configuration.test_name
end

#### Some Common Functionality ######
$ADDRESS = "1999 Broadway"
$CITY = "Denver"
$STATE = "Colorado"
$STATE_ABBR = "CO"
$ZIP = "80222"
$PHONE = "303-555-1234"
$VISA_TEST_CC = "4444444444444448"




