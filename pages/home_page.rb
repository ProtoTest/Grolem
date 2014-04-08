require './sections/logged_in_header'

module Pages
  class HomePage<BasePage
    attr_reader :header
    include Sections
    set_url "/"
    section :header, LoggedInHeader, '.okl-header'
    section :footer, LoggedInFooter, '#footer'

    def wait_for_elements
      wait_until_header_visible
    end

    def LogOut
      header.LogOut
      LoginPage.new
    end

    def WaitForSessionToExpire
      sleep (20*60)
      section :header, LoggedOutHeader, '.okl-header'
      self
    end
  end

end