require 'site_prism'
require 'welcome_splash_page'
require 'signup_modal'
include Pages

module Pages
  class LoginPage < SitePrism::Page
    attr_reader :email_field, :password_field,:log_in_button,:join_now_link,:facebook_login_link,:keep_logged_in_cbx

      element :email_field, '#email2'
      element :password_field,'#password2'
      element :log_in_button , 'button[type=submit]', :text => "LOG IN"
      element :join_now_link , '.joinLink'
      element :facebook_login_link , '.fblogin'
      element :keep_logged_in_cbx,'#remember'

    def LoginWithInfo email, password
      email_field.set email
      password_field.set password
      log_in_button.click
      WelcomeSplashPage.new
    end

    def LoginWithBlankInfo
      email_field.set ''
      password_field.set ''
      log_in_button.click
      LoginPage.new
    end

    def JoinNow
      join_now_link.click
      SignupModal.new
    end
  end
end