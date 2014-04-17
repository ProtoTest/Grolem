module Pages
  class MobileHomePage<BasePage
    include Sections
    set_url "/layout/mobile"
    section :header, MobileHeader, '.page-header'
    section :footer, MobileFooter, '.page-footer'
    elements :all_sales_events, 'a.block'
    element :first_sales_events, '.hero'
    element :new_sales_section, 'h2', :text => "Today's New Sales"
    elements :todays_sales_events, '.items.today > ul > li > a'
    elements :ending_sales_events, '.items.ending > ul > li > a'

    def GoToLoginPage
      header.OpenMenu.GoToLogin
    end

    def LogOut
      footer.LogOut
    end

    def GoToCurrentSale(position)
      wait_for_all_sales_events
      $logger.Log "Navigating to sale #{all_sales_events[position].text}"
      all_sales_events[position].click
      MobileSalesEvent.new(text)
    end

    def GoToFirstSale
      first_sales_events.click
      MobileSalesEvent.new
    end

    def WaitForSessionToExpire
      $logger.Log("#{__method__}(): Waiting for 20 minutes to verify session has expired")
      sleep (20*60)

      self
    end

    # Go to a current sale by its 0-indexed position in the all sales header dropdown.
    def GoToRandomCurrentSale
      wait_until_new_sales_section_visible

      # Open the sales drop down: sales aren't loaded until the drop down is visible.
      wait_for_ending_sales_events

      position = rand(todays_sales_events.size)
      $logger.Log "Navigating to sale #{ending_sales_events[position].text}"
      ending_sales_events[position].click
      MobileSalesEvent.new
    end

  end
end

