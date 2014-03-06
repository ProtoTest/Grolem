require 'base_page'
require 'register_modal'
require 'login_page'
include Pages
include Core

module Pages
  class SignupModal

    def initialize
      @email_field = WebElement.new '#email'
      @shop_now_button = WebElement.new :xpath, "//*[@type='submit']"
      @login_button = WebElement.new 'a[data-panel=modalSignup-login]'
      @okl_logo = WebElement.new'.intro'
    end


    def  EnterEmail username
      @email_field.set username
      @shop_now_button.click
      RegisterModal.new
    end

    def  EnterEmailThatAlreadyExists username
      @email_field.set username
      @shop_now_button.click
      SignupModal.new
    end

    def Login
      @login_button.click
      LoginPage.new
    end
  end
end