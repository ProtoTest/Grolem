require "base_page"

class SignupModal < BasePage

  element :email_field, ".email"
  element :shop_now_button, "Shop Now"
  element :login_button, "Log In"
  element :okl_logo, "#intro"

  def  Register username
    email_field.set username
    login_button.click
  end

  def ClickLogin
    :login_button.click
  end
end