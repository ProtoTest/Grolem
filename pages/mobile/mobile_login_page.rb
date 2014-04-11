module Pages
  class MobileLoginPage<LoginPage
    set_url '/login'
    def LoginWithInfo email, password
      email_field.set email
      password_field.set password
      log_in_button.click
      MobileHomePage.new
    end
  end
end