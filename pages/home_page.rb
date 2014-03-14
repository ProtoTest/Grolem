require "site_prism"
require './pages/login_modal'
require './sections/logged_in_header'

module Pages
  class HomePage<SitePrism::Page
    set_url "/"
    section :logged_in_header, Sections::LoggedInHeader, 'header'

    def LogOut
      logged_in_header.LogOut
      LoginPage.new
    end
  end

end