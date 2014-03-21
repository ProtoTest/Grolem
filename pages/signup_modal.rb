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
    element :test , '.test'
    set_url ''


    def  EnterEmail username
      email_field.set username
      shop_now_button.click
      RegisterModal.new
    end

    def  EnterEmailThatAlreadyExists username
      email_field.set username
      shop_now_button.click
      SignupModal.new
    end

    def GoToLoginPage
      #sleep 2
      login_button.click
      #sleep 2
      LoginModal.new
    end
  end
end