require "site_prism"
require './pages/login_modal'
require './sections/logged_in_header'

include Sections
module Pages
  class HomePage<SitePrism::Page
    set_url "/"
    section :logged_in_header, LoggedInHeader, 'header'

    def LogOut
      logged_in_header.LogOut
      LoginPage.new
    end
  end

end