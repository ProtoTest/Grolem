$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'capybara-screenshot'
require 'site_prism'
require 'capybara-screenshot/rspec'
require 'selenium-webdriver'

HOST = ENV['HOST'] || 'local'
DEBUG = ENV['DEBUG'] == 'true' ? true : false
# All tests are end-to-end (going through browser) by default.

Capybara.default_driver = :selenium
Capybara.app_host = 'http://www.google.com'
Capybara.default_wait_time = 5

RSpec.configure do |config|
  config.include Capybara::DSL
  config.treat_symbols_as_metadata_keys_with_true_values = true
end



