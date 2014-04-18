require 'spec_helper'
require_all 'pages'

include Pages

feature 'Mobile Events' do

# run this once before all of the scenarios
  before(:all) do
    @email = "msiwiec@mailinator.com"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'

    # register the user
    register_user(@firstname, @lastname, @password, @email)
  end

  before(:each) do
    @page = MobileHomePage.new
    @page.load
    @page = @page.GoToLoginPage.LoginWithInfo(@email, @password)
    # Select a random sales event page
    #there's a bit of a bug--doesn't always go to the sale page...
    begin
      @sale_event = @page.GoToRandomCurrentSale
    rescue
      @sale_event = @page.GoToRandomCurrentSale
    end
  end

  scenario 'Sort by Lowest Price' do
    @sale_event.SortItems(:low_price).VerifyPriceListSortedByLowestPrice

  end

  scenario 'Sort by Featured' do
    @sale_event.SortItems(:featured)
  end

  scenario 'Sort by Available Now' do
    @sale_event.SortItems(:available)
    products = @sale_event.products_sold_out
    products.size.should == 0
  end

  scenario 'Verify Inventory Badge works and rendered correctly' do
    products = @sale_event.products_sold_out
    products.size.should_not == 0
  end

  scenario 'Verify Vintage Badge works and rendered correctly' do
    raise "I'm not finding any Vintage badges on any products in the mobile sales event pages"
  end

  scenario 'Header present and rendered correctly' do
    @sale_event.header.should have_back_button
    @sale_event.header.should have_cart_button
    @sale_event.header.should have_okl_logo
  end

  scenario 'Footer present and rendered correctly' do
    @sale_event.footer.should have_upcoming_sales_link
    @sale_event.footer.should have_my_account_link
    @sale_event.footer.should have_log_out_link
    @sale_event.footer.should have_help_link
    @sale_event.footer.should have_non_mobile_link
    @sale_event.footer.should have_terms_link
    @sale_event.footer.should have_privacy_link
  end

  scenario 'Footer links work' do
    @sale_event.footer.VerifyLoggedInFooterLinks
  end
end