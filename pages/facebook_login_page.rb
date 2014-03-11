require 'site_prism'

module Pages
  class FacebookLoginPage < SitePrism::Page
    set_url "http://www.facebook.com/login.php"
    element :email_field, "#email"
    element :password_field, '#pass'
    element :login_button, '#u_0_1'
    element :okay_button, :xpath, "//button[@name='__CONFIRM__']"
    element :cancel_button, 'button',:text=>"Cancel"

    def LoginAs email, pass
      email_field.set email
      password_field.set pass
      login_button.click
      if(has_okay_button?)
        okay_button.click
      end
      HomePage.new
    end
  end
end

