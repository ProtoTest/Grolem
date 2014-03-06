require 'base_page'
require 'welcome_splash_page'
include Pages

module Pages
  class RegisterModal
    def initialize
    @back_link = WebElememt.new  'button', :text=> 'BACK'
    @first_name_field = WebElememt.new  '#firstName'
    @last_name_field  = WebElememt.new  '#lastName'
    @password_field = WebElememt.new  '#password'
    @shop_today_sales_button = WebElememt.new  'button', :text => "SHOP TODAY'S SALES"
    @log_in_link = WebElememt.new 'a', :text=> 'LOG IN'
    @this_is_stupid = WebElememt.new  'a', :text=> 'LOG IN'
    end

    def EnterInfo firstname, lastname, password
      first_name_field.set firstname
      last_name_field.set lastname
      password_field.set password
      shop_today_sales_button.click
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
    end
  end
end