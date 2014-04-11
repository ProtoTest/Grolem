module Pages
  class MobileHomePage<BasePage
    attr_reader :header
    include Sections
    set_url "/layout/mobile"
    section :header, MobileHeader, 'header'
    section :footer, LoggedInFooter, 'footer'


  end
end

