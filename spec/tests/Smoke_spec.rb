require 'spec_helper'
require_all 'pages'

include Pages


feature 'Smoke Test' do

# run this once before all of the scenarios
  before(:all) do
    @rand = rand(1000).to_s
    @email = "testuser" + @rand + "@mailinator.com"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @fullname = "#{@firstname} #{@lastname}"

# register the user
  register_user(@firstname, @lastname, @password, @email)

  end

  before(:each) do
    login(@email, @password)
  end

  after(:each) do

  end


  scenario 'Register, Login, Search, Add item to Cart, Checkout' do
    save_payment_info = false
    use_shipping_address = true

    @page = HomePage.new
    @page.load
    @page.header.SearchFor("item").
        GoToFirstProduct.
        AddToCart.
        header.GoToCart.
        CheckOutNow.
        EnterAddress(@firstname, @lastname, $ADDRESS, nil, $CITY, $STATE, $ZIP, $PHONE).
        EnterCreditCardInfo(@fullname, $VISA_TEST_CC, "1", "2020", "123", save_payment_info, use_shipping_address).
        Continue.PlaceOrder.VerifyOrderCompleted

  end


end

