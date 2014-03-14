require "site_prism"
require './pages/login_modal'
require './sections/logged_in_header'

module Pages
  class HomePage<SitePrism::Page
    set_url "/"
    section :header, Sections::LoggedInHeader, 'header'

    def LogOut
      header.LogOut
      LoginPage.new
    end
  end

end