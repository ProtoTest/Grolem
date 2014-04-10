class MobileHomePage<BasePage
  attr_reader :header
  include Sections
  set_url "/"
  section :header, MobileHeader, '.okl-header'
  section :footer, LoggedInFooter, '#footer'


end
