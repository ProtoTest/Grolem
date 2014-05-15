module Pages
  class FacebookShareModalPage < BasePage
    element :message_text_area, '#u_0_4'
    element :product_name, :xpath, "//*[contains(@class,'UIShareStage_Title')]/span"
    element :share_with_popup_menu, '.uiButtonText'
    element :share_link_btn, :xpath, "//button[contains(text(), 'Share Link')]"
    element :cancel_link_btn, :xpath, "//button[contains(text(), 'Cancel')]"

    def VerifyProductNameDisplayed(product_name_str)
      if not product_name.text.eql?(product_name_str)
        raise "Failed to verify the product title text '#{product_name_str}' is displayed in the facebook share modal popup"
      end

      self
    end

    def ShareWith(who)
      share_with_popup_menu.click

      xpath_str = "//*[contains(text(), '%s')]" % who
      find(:xpath, xpath_str).click

      self
    end

    def CancelSharing
      cancel_link_btn.click
    end

    # Optional message for sharing
    def ShareLink(msg=nil)
      message_text_area.set msg if msg
      share_link_btn.click
    end
  end
end