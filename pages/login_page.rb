require 'site_prism'

module Pages
  class LoginPage < SitePrism::Page
    set_url '/login'
    attr_reader :email_field, :password_field,:log_in_button,:join_now_link,:facebook_login_link,:keep_logged_in_cbx

    element :email_field, '#email'
    element :password_field,'#password'
    element :log_in_button , 'input[name=submit]', :text => "LOG IN"
    element :join_now_link , 'img[alt=Join Now]'
    element :facebook_login_link , 'a',:text=>'Login with Facebook'
    element :keep_logged_in_cbx,'#remember'
    element :forgot_password_link, 'a',:text=>'Forgot Password?'

    element :email_address_field, '#forgotEmail'
    element :send_email_button , '#forgotSubmit'

    def LoginWithInfo email, password
      email_field.set email
      password_field.set password
      log_in_button.click
      HomePage.new
    end

    def ForgotPassword email
      forgot_password_link.click
      email_address_field.set email
      send_email_button.click
    end
  end
end
