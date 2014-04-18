require 'spec_helper'
require_all 'pages'

include Pages


feature 'Mobile Smoke Test' do

# run this once before all of the scenarios
  before(:all) do
    @rand = rand(1000).to_s
    @email = "testuser" + @rand + "@mailinator.com"
    @password = OKL_USER_PASSWORD
    @firstname = OKL_USER_FIRST_NAME
    @lastname = OKL_USER_LAST_NAME
    @fullname = "#{@firstname} #{@lastname}"

# register the user
  register_user(@firstname, @lastname, @password, @email)

  end

  before(:each) do

  end

  after(:each) do

  end


  scenario 'Register, Login, Search, Add item to Cart, Checkout' do

    shipping_info = {:first => @firstname,
                     :last => @lastname,
                     :address1 => ADDRESS1,
                     :city => CITY,
                     :state => STATE,
                     :state_abbr => STATE_ABBR,
                     :zip => ZIP,
                     :phone => PHONE}

    billing_info = {:fullname => @fullname,
                    :credit_card_num => VISA_TEST_CC,
                    :exp_month => CC_EXP_MONTH,
                    :exp_year => CC_EXP_YEAR,
                    :cvc => VISA_TEST_CCV}

    @page = MobileHomePage.new
    @page.load
    @page = @page.GoToLoginPage.LoginWithInfo(@email, @password)

    @page.header.SearchFor("lamp").
        GoToFirstProduct(:available).
        AddToCart.
        ItemAddedModal_Checkout.
        CheckOutNow.
        EnterShippingDetails(shipping_info).
        Next.
        EnterPaymentInfo(billing_info).
        Next.PlaceOrder.VerifyOrderCompleted

  end

end

