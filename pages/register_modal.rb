require 'welcome_splash_page'
include Pages

module Pages
  class RegisterModal< BasePage
    attr_reader :back_link,:first_name_field,:last_name_field,:password_field,:shop_today_sales_button,:log_in_link
      element :back_link,  'button', :text=> 'BACK'
      element :first_name_field,  '#firstName'
      element :last_name_field,  '#lastName'
      element :password_field,  '#password'
      element :shop_today_sales_button,  'button', :text => "SHOP TODAY'S SALES"
      element :log_in_link, 'a', :text=> 'LOG IN'

    set_url ''

    def wait_for_elements
      wait_until_first_name_field_visible
      wait_until_last_name_field_visible
      wait_until_shop_today_sales_button_visible

      self
    end

    def EnterInfo firstname, lastname, password
      #first_name_field.set firstname
      #last_name_field.set lastname
      password_field.set password
      shop_today_sales_button.click
      sleep 1
      WelcomeSplashPage.new
    end

    def EnterBlankInfo
      first_name_field.set ''
      last_name_field.set ''
      password_field.set ''
      shop_today_sales_button.click
      RegisterModal.new
    end

    def Back
      back_link.click
      SignupModal.new
    end
  end

  ############################ Common Repeatable Actions ########################
  def register_user(first_name, last_name, password, email)
    page = SignupModal.new
    page.load

    page = page.EnterEmail(email)

    # If the RegisterModal page is returned, then the email address is not in the system yet.
    # Continue to enter information to register the account
    if page.class.eql?(RegisterModal)
      page.EnterInfo(first_name, last_name, password).ClosePanel.LogOut
    else
      $logger.Log "The email address '#{email}' is already registered"
    end

  end
end