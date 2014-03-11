$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'core'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'pages'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'sections'))
$LOAD_PATH.unshift(File.dirname(__FILE__))



require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'rspec/core'
require 'capybara/rspec/matchers'
require 'capybara/rspec/features'
require 'site_prism'
require 'selenium-webdriver'
require 'browsers'
require "command_logger"
require 'config'
require "capybara-screenshot"
require 'capybara-screenshot/rspec'
require "aquarium"
require "syntax"
require 'require_all'
require 'site_prism'
require_all 'pages'
require_all 'sections'

include Browsers

HOST = ENV['HOST'] || 'local'
DEBUG = ENV['DEBUG'] == 'true' ? true : false

Capybara.default_driver = :selenium
Capybara.app_host = RSpec.configuration.default_url
Capybara.default_wait_time = RSpec.configuration.element_wait_sec
Capybara.run_server = false;

Capybara::Screenshot.append_timestamp = false
Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  "screenshot_" + RSpec.configuration.test_name
end
setup_browser










