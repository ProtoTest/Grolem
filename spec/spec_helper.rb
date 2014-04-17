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
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'
require 'capybara_extensions'
require 'aquarium'
require 'syntax'
require 'browsermob/proxy'
require 'require_all'
require 'base_page'
require 'base_section'
require 'config'
require 'command_logger'
require_all 'sections'
require_all 'pages'

setup_browser


















