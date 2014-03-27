require 'spec_helper'
require_all 'pages'

include Pages


feature 'My Account' do

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
    @page = login(@email, @password)
  end

  after(:each) do
    sleep 4
  end

  scenario 'Add credit card to account' do
    address = {:first => @firstname,
               :last => @lastname,
               :address1 => $ADDRESS,
               :city => $CITY,
               :state => $STATE,
               :state_abbr => $STATE_ABBR,
               :zip => $ZIP,
               :phone => $PHONE}

    billing_info = {:fullname => @fullname,
                    :credit_card_num => $VISA_TEST_CC,
                    :exp_month => "1",
                    :exp_year => "2020",
                    :cvc => "123"}

    @page = MyAccountInformationPage.new
    @page.load

    @page.AddPaymentMethod.
        EnterBillingInfo(billing_info).
        EnterBillingAddressAndPhone(address).
        SavePaymentInfo

    # TODO: Verify the payment added!
    # TODO: Possible partial (section) for the credit card last 4, etc.
  end

=begin
  scenario 'Remove credit card from account' do

  end

  scenario 'Add shipping address to account' do

  end

  scenario 'Remove shipping address to account' do

  end

  scenario 'Verify my orders link works' do

  end
=end
end

