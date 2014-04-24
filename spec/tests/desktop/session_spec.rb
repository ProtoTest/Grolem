require 'spec_helper'
include Pages

feature 'Session' do
  before(:all) do
    @rand = rand(1000).to_s
    @email = "testuser" + @rand + "@mailinator.com"
    @password = OKL_USER_PASSWORD
    @firstname = OKL_USER_FIRST_NAME
    @lastname = OKL_USER_LAST_NAME

    # register the user
    register_user(@firstname, @lastname, @password, @email)
  end

  before(:each) do
    @page = LoginPage.new
    @page.load
    @page = @page.LoginWithInfo @email, @password
  end

  scenario 'Cart Session Expiration' do
    #@page = @page.header.SearchFor 'table'
    #@page = @page.GoToFirstProduct(:available).AddToCart
    #@page = ShoppingCartPage.new
    #@page.load
    #$logger.Log("Waiting for 10 minutes to verify shopping cart session has expired")
    #sleep (60 * 10)
    #@page.should have_cart_timed_out_message
    #@page.should have_item_reservation_duration :text=>'00:00'
  end

  scenario 'Auth Session Expiration' do
    #@page.WaitForSessionToExpire
    #@page.header.should be_all_there
    #@page.should have_text "LOG IN"
  end
end