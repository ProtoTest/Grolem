require "../core/base_page"
require "../pages/register_modal"
require "../pages/login_page"
include Pages

module Pages
  class SignupModal < BasePage
    set_url ''
    set_url_matcher /onekingslane.com\/?/
    element :email_field, '#email'
    element :shop_now_button, :xpath, "//*[@type='submit']"
    element :login_button, 'a[data-panel=modalSignup-login]'
    element :okl_logo, '.intro'

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

    def Login
      login_button.click
      LoginPage.new
    end
  end
end