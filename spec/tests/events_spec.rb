require 'spec_helper'
require_all 'pages'

include Pages

feature 'Events' do

# run this once before all of the scenarios
  before(:all) do
    @email = "msiwiec@mailinator.com"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
  end

  before(:each) do
    @page = login(@email, @password)
    # Select a random page
  end

  scenario "Ordering by price ascending should re-order the sale items" do
    @sale_event = @page.header.GoToCurrentSale(rand(16))
    puts @sale_event.sort_options.size
    @sale_event.SortItems(:low_price)
    prices = @sale_event.PriceList
    prices.should == prices.sort
  end

end