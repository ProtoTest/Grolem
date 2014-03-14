require 'custom_formatter'
RSpec.configure do |config|
  config.include Capybara::DSL
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.add_setting :default_browser, :default => Browsers::Firefox;
  config.add_setting :remote_driver, :default => false
  config.add_setting :host_ip, :default => "localhost"
  config.add_setting :element_wait_sec, :default => 5
  config.add_setting :screenshot_on_failure, :default => true
  config.add_setting :command_logging, :default => true
  config.add_setting :mock_mobile, :default =>true
  config.add_setting :default_url, :default => "https://bkitchener:bkitchener123!@qa02.newokl.com"
  config.add_setting :ldap_username, :default => "bkitchener"
  config.add_setting :ldap_user_password, :default =>"bkitchener123!"
  config.add_formatter :documentation,'output.txt'
  config.add_formatter CustomFormatter,'output.html'
  config.add_setting :test_name, :default=>''

  config.before(:all) do

  end

  config.after(:all) do

  end

  config.before(:each) do
    $logger = CommandLogger.new
    path = example.metadata[:description]
      config.test_name = path
  end

  config.after(:each) do

  end
end

Capybara.configure do |config|
  config.match = :prefer_exact
  config.exact = false
  config.ignore_hidden_elements = true
  config.visible_text_only = true
end



