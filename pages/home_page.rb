require "site_prism"
require './pages/login_modal'
require './sections/logged_in_header'

include Sections
module Pages
  class HomePage<SitePrism::Page
    set_url "/"
    section :header, LoggedInHeader, 'header'

    def LogOut
      header.LogOut
      LoginPage.new
    end
  end

end