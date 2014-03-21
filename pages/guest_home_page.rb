require "site_prism"
require './sections/logged_out_header'

include Sections
module Pages
  class GuestHomePage<BasePage
    set_url "/?f=m"
    section :header, Sections::LoggedOutHeader, 'header'

  end

end