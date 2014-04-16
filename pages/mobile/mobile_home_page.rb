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

    def WaitForSessionToExpire
      $logger.Log("#{__method__}(): Waiting for 20 minutes to verify session has expired")
      sleep (20*60)

      self
    end
  end
end

