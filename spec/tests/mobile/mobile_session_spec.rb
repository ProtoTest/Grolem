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

    # register the user
    register_user(@firstname, @lastname, @password, @newemail)
  end

  before(:each) do
    @page = MobileHomePage.new
    @page.load
    @page = @page.GoToLoginPage.LoginWithInfo(@newemail, @password)
  end

  scenario 'Cart Session Expiration' do
    @page = @page.header.SearchFor 'table'
    @page = @page.GoToFirstProduct(:available).AddToCart
    @page = MobileCartPage.new
    @page.load
    sleep (60 * 10)
    @page.should have_item_reservation_duration :text=>'00:00'
  end

  scenario 'Auth Session Expiration' do
    @page = @page.WaitForSessionToExpire.header.OpenMenu
    @page.header.should be_all_there
    @page.should have_text "Log In/Sign Up"
  end
end