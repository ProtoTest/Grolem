module Pages
  class PayPalPage < BasePage
    @@email = "buyer_1296346701_per@onekingslane.com"
    @@password = "prjx2010"

    element :login_email, '#login_email'
    element :login_password, '#login_password'
    element :login_btn, '#submitLogin'

    # Review your information div. AJAXified page displayed after logged in
    element :continue_btn, '#continue'

    ## Class static variable accessor
    def self.email
      @@email
    end

    ## Class static variable accessor
    def self.password
      @@password
    end

    def LoginToPayPal
      wait_until_login_email_visible
      login_email.set @@email
      login_password.set @@password
      login_btn.click

      self
    end

    def CompletePayPalCheckout(mobile_site=false)
      wait_until_continue_btn_visible(15)
      continue_btn.click

      if mobile_site
        return MobileReviewOrderPage.new
      else
        return ReviewOrderPage.new
      end
    end

  end
end