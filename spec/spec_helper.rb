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
include Browsers

HOST = ENV['HOST'] || 'local'
DEBUG = ENV['DEBUG'] == 'true' ? true : false

Capybara.default_driver = :selenium
Capybara.app_host = RSpec.configuration.default_url
Capybara.default_wait_time = RSpec.configuration.element_wait_sec
Capybara.run_server = false;

def SetDefaultBrowser
  puts "SetDefaultBrowser"
  Capybara.register_driver :selenium do |app|
    if RSpec.configuration.remote_driver
      Capybara::Selenium::Driver.new(app, :browser => GetRemoteBrowser())
    end
      Capybara::Selenium::Driver.new(app, :browser => RSpec.configuration.default_browser)
  end
end

def GetRemoteBrowser
    Selenium::WebDriver.for(:remote, :desired_capabilities => RSpec.configuration.default_browser)
end
SetDefaultBrowser()






