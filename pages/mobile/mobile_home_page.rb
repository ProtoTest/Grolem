module Pages
  class MobileHomePage<BasePage
    include Sections
    set_url "/layout/mobile"
    section :header, MobileHeader, '.page-header'
    section :footer, MobileFooter, '.page-footer'

    elements :all_sales_events, 'a.block'
    element :first_sales_events, '.hero'

    def GoToLoginPage
      header.OpenMenu.GoToLogin
    end

    def LogOut
      footer.LogOut
    end

    def GoToCurrentSale(position)
      wait_for_all_sales_events
      @logger.Log "Navigating to sale #{all_sales_events[position].text}"
      all_sales_events[position].click
      SalesEvent.new(text)
    end

    def GoToFirstSale
      first_sales_events.click

    end

    def WaitForSessionToExpire
      @logger.Log("#{__method__}(): Waiting for 20 minutes to verify session has expired")
      sleep (20*60)

      self
    end
  end
end

