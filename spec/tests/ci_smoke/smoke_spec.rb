require 'spec_helper'
require_all 'pages'
RSpec.configuration.remote_driver = true
RSpec.configuration.host_ip = 'http://qa03.corp.onekingslane.biz:4444/wd/hub'

include Pages


feature 'Smoke Tests' do

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



  scenario 'Desktop Smoke Test' do
    save_payment_info = false
    use_shipping_address = true

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
    login(@email, @password)
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


  scenario 'Mobile Layout Smoke Test' do

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

