require 'site_prism'
require 'register_modal'
require 'login_modal'

module Pages
  class SignupModal < BasePage
    attr_reader :email_field,:shop_new_button,:login_button,:okl_logo
      element :email_field,'#email'
      element :shop_now_button, :xpath, "//*[@type='submit']"
      element :login_button, 'a[data-panel=modalSignup-login]'
      element :okl_logo, '.intro'
      element :error_label, :xpath, "//div/p/span[contains(@class,'error')]"
    element :test , '.test'
    set_url ''


    def  EnterEmail username
      email_field.set username
      shop_now_button.click

      sleep 1
      if has_error_label? and error_label.text.include?("This email is already a registered member")
        return SignupModal.new
      else
        return RegisterModal.new
      end
    end

    def GoToLoginPage
      #sleep 2
      login_button.click
      #sleep 2
      LoginModal.new
    end
  end
end