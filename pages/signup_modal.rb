require 'site_prism'
require 'register_modal'
require 'login_modal'

module Pages
  class SignupModal < SitePrism::Page
    attr_reader :email_field,:shop_new_button,:login_button,:okl_logo
      element :email_field,'#email'
      element :shop_now_button, :xpath, "//*[@type='submit']"
      element :login_button, 'a[data-panel=modalSignup-login]'
      element :okl_logo, '.intro'
    element :test , '.test'
    set_url ''

    def  EnterEmail username
      if(has_email_field?)
        email_field.set username
      shop_now_button.click
      end
      RegisterModal.new
    end

    def  EnterEmailThatAlreadyExists username
      email_field.set username
      shop_now_button.click
      SignupModal.new
    end

    def Login
      login_button.click
      LoginModal.new
    end
  end
end