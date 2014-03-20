require 'spec_helper'
require_all 'pages'

include Pages


feature 'Smoke Test' do

# run this once before all of the scenarios
  before(:all) do
    @rand = rand(1000).to_s
    #@email = "testuser" + @rand + "@mailinator.com"
    @email = "msiwiec@mailinator.com"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @fullname = "#{@firstname} #{@lastname}"

# register the user
  #register_user(@firstname, @lastname, @password, @email)

  end

  before(:each) do
    login(@email, @password)
    remove_all_items_from_cart
  end

  after(:each) do
    sleep 5
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
        EnterAddress(@firstname, @lastname, $ADDRESS, $CITY, $STATE, $ZIP, $PHONE).
        EnterCreditCardInfo(@fullname, $VISA_TEST_CC, "1", "2020", "123", save_payment_info, use_shipping_address)

  end


end

