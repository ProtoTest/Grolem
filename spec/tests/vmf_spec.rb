require 'spec_helper'
require_all 'pages'

include Pages


feature 'Vintage Market Find (VMF)' do

# run this once before all of the scenarios
  before(:all) do
    @rand = rand(1000).to_s
    @email = "testuser" + @rand + "@mailinator.com"
    @email = "testuser680@mailinator.com"
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

  scenario 'Header and page renders correctly' do
    @page.header.GoToVintage

  end

  scenario 'Badges: Inventory is functional' do

  end

  scenario 'Badges: Vintage tag is visible for vintage items' do

  end

  scenario 'Today\'s Arrival Carousel Works' do

  end

  scenario 'Shop by Vendor link works on product detail page (PDP)' do
    @page = @page.header.GoToVintage.GoToFirstProduct

    vmf_vendor_name = @page.vmf_vendor_section.vendor_name.text
    @page.GoToVMFVendorPage.VerifyVendorPageDisplayed(vmf_vendor_name)
  end
end

