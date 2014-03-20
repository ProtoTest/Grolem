require './sections/logged_in_header'

module Pages
  class HomePage<SitePrism::Page
    attr_reader :header

    include Sections
    set_url "/"
    section :header, LoggedInHeader, '.okl-header'

    def LogOut
      header.LogOut
      LoginPage.new
    end
  end

end