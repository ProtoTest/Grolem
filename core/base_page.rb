require "site_prism"
require "../core/spec_helper"

module Pages
  class BasePage < SitePrism::Page
    set_url ""
    set_url_matcher /onekingslane.com\/?/

    def initialize
      puts "Base Page Called"
    end
  end
end
