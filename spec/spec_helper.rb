$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'core'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'pages'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'site_prism'
require 'selenium-webdriver'
require 'browsers'
require 'config'
require "capybara-screenshot"
require "aquarium"
require "logger"
require "command_logger"
require "test_logger"
include Browsers

HOST = ENV['HOST'] || 'local'
DEBUG = ENV['DEBUG'] == 'true' ? true : false

Capybara.default_driver = :selenium
Capybara.app_host = RSpec.configuration.default_url
Capybara.default_wait_time = RSpec.configuration.element_wait_sec
Capybara.run_server = false;











