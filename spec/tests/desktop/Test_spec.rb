require 'spec_helper'
require 'login_page'
require 'mailinator_page'
include Pages


feature 'User Login' do
  before(:all) do
    @rand = rand(1000).to_s
    @rand_username = "testuser" + @rand
    @newemail =  @rand_username + "@mailinator.com"
    @newemail2 =  @rand_username + @rand + "@mailinator.com"
    @password = "Proto123!"
    @firstname = "TestUser"
    @lastname = "ProtoTest"
    @email = "prototest@mailinator.com"
    @facebookemail = "bkitchener@prototest.com"
  end

  #scenario 'Cart Session Expiration' do
  #  @page = LoginPage.new
  #  @page.load
  #  @page = @page.LoginWithInfo @facebookemail, @password
  #  @page = @page.header.SearchFor 'table'
  #  @page = @page.GoToFirstProduct.AddToCart
  #  @page = ShoppingCartPage.new
  #  @page.load
  #  sleep (60 * 10)
  #  @page.should have_cart_timed_out_message
  #  @page.should have_item_reservation_duration :text=>'00:00'
  #end

  scenario 'Test' do
    @page = LoginPage.new

  end


end

