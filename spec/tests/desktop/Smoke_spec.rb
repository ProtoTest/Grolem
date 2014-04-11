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

    shipping_info = {:first => @firstname,
                     :last => @lastname,
                     :address1 => $ADDRESS,
                     :city => $CITY,
                     :state => $STATE,
                     :zip => $ZIP,
                     :phone => $PHONE}

    billing_info = {:fullname => @fullname,
                    :credit_card_num => $VISA_TEST_CC,
                    :exp_month => "1",
                    :exp_year => "2020",
                    :cvc => "123"}

    @page = HomePage.new
    @page.load
    @page.header.SearchFor("item").
        GoToFirstProduct.
        AddToCart.
        header.GoToCart.
        CheckOutNow.
        EnterShippingDetails(shipping_info).
        Continue.
        EnterBillingInfo(billing_info, save_payment_info, use_shipping_address).
        Continue.PlaceOrder.VerifyOrderCompleted

  end


end

