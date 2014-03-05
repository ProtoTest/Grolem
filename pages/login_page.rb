require_relative "../core/base_page"
require_relative "../pages/welcome_splash_page"
require_relative "../pages/signup_modal"
require_relative "../core/element"
include Pages

module Pages
  class LoginPage

    def initialize
      @email_field = WebElement.new '#email2'
      @password_field= WebElement.new'#password2'
      @log_in_button = WebElement.new 'button[type=submit]', :text => "LOG IN"
      @join_now_link = WebElement.new '.joinLink'
      @facebook_login_link = WebElement.new '.fblogin'
      @keep_logged_in_cbx = WebElement.new'#remember'
    end

    def LoginWithInfo email, password
      @email_field.set email
      @password_field.set password
      @log_in_button.click
      WelcomeSplashPage.new
    end

    def JoinNow
      @join_now_link.click
      SignupModal.new
    end
  end
end