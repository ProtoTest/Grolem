module Pages
  class MobileHomePage<BasePage
    include Sections
    set_url "/layout/mobile"
    section :header, MobileHeader, '.page-header'
    section :footer, MobileFooter, '.page-footer'

    def GoToLoginPage
      header.OpenMenu.GoToLogin
    end

    def LogOut
      footer.LogOut
    end
  end
end

