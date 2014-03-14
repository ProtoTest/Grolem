require "site_prism"
require './pages/login_modal'
require './sections/logged_in_header'

include Sections
module Pages
  class GuestHomePage<SitePrism::Page

    set_url "/?f=m"
    section :header, LoggedOutHeader, 'header'

  end

end