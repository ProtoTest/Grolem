require 'spec_helper'
include Pages

feature 'Session' do
  before(:all) do
    @rand = rand(1000).to_s
    @newemail = "testuser" + @rand + "@mailinator.com"
    @newemail2 =  "testuser" + @rand + @rand + "@mailinator.com"
    @password = 'Proto123!'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @newemail = 'prototest@mailinator.com'
    @facebookemail = 'bkitchener@prototest.com'
  end

  before(:each) do
  end

  scenario 'Cart Session Expiration' do
    @page = LoginPage.new
    @page.load
    @page = @page.LoginWithInfo @facebookemail, @password
    @page = @page.header.SearchFor 'table'
    @page = @page.GoToFirstProduct.AddToCart
    @page = ShoppingCartPage.new
    @page.load
    sleep (60 * 10)
    @page.should have_cart_timed_out_message
    @page.should have_item_reservation_duration :text=>'00:00'
  end

  scenario 'Auth Session Expiration' do
    @page = LoginPage.new
    @page.load
    @page = @page.LoginWithInfo @facebookemail, @password
    @page.WaitForSessionToExpire
    @page.header.should be_all_there
    @page.should have_text "LOG IN"
  end
end