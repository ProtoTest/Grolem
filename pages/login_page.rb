include Pages

module Pages
  class LoginPage <BasePage
    element :email_field,".email2"
    element :password_field,".password2"
    element :join_now_link ,"#joinLink"
    element :facebook_login_link, "#fblogin"
    element :keep_logged_in_cbx, ".remember"
  end
end
