require 'custom_formatter'

def reset_capybara
  Capybara.reset_sessions!
  Capybara.reset!

  Capybara.configure do |config|
    config.match = :prefer_exact
    config.exact = false
    config.ignore_hidden_elements = true
    config.visible_text_only = true
  end

  page.driver.browser.manage.delete_cookie('ewokAuth')
  page.driver.browser.manage.delete_cookie('ewokAuthGuestPass')
  page.driver.browser.manage.delete_cookie('keepLogin')
  page.driver.browser.manage.delete_cookie('is_member')
  page.driver.browser.manage.window.maximize
end

RSpec.configure do |config|
  config.include Capybara::DSL
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.add_setting :default_browser, :default => Browsers::Chrome
  config.add_setting :remote_driver, :default => false
  config.add_setting :host_ip, :default => "localhost"
  config.add_setting :element_wait_sec, :default => 20
  config.add_setting :screenshot_on_failure, :default => true
  config.add_setting :command_logging, :default => true
  config.add_setting :mock_mobile, :default =>true
  config.add_setting :default_url, :default => "https://bkitchener:bkitchener123!@qa02.newokl.com"
  config.add_setting :ldap_username, :default => "bkitchener"
  config.add_setting :ldap_user_password, :default =>"bkitchener123!"
  config.add_formatter :documentation,'output.txt'
  config.add_formatter CustomFormatter,'output.html'
  config.add_setting :test_name, :default=>''
  config.add_setting :command_delay_sec, :default=>0

  config.before(:all) do
    $logger = CommandLogger.new
    reset_capybara
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

  end
end



