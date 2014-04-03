require 'spec_helper'
require_all 'pages'

include Pages


feature 'Product Details' do

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

  scenario 'Select Product Quantity and size' do
    @page = HomePage.new
    @page.load
    @page = @page.header.SearchFor("Bleeker Runner").
        GoToFirstProductNotSoldOutOnHold

    qty = 2
    size = nil
    # extract a size to use from the dropdown options
    @page.size_options.each do |opt|
      if not opt.text.include?("SOLD OUT") and not opt.text.include?("ON HOLD")
        size = opt.text
      end
    end

    raise "Failed to extract a size from the product size dropdown" if size.nil?

    @page.UpdateSizeQty(size, qty)
  end

  scenario 'Add Product to Cart' do
    @page = HomePage.new
    @page.load
    @page.header.SearchFor("lamp").GoToFirstProductNotSoldOutOnHold.AddToCart.VerifyItemAddedToCart
  end

  scenario 'Search is displayed in Product page header, UI is correct and Search is functional' do
    @page = HomePage.new
    @page.load
    @page = @page.header.SearchFor("lamp").
        GoToFirstProductNotSoldOutOnHold

    # The header contains the search elements, verify they are all there
    @page.header.search_container.should be_all_there

    @page.header.SearchFor("rug").
        GoToFirstProductNotSoldOutOnHold
  end

  scenario 'White Glove Tool Tip' do

  end

  scenario 'Add Product to Cart' do

  end

  scenario 'Social Sharing - Facebook' do

  end

  scenario 'Social Sharing - Email' do

  end

  scenario 'Social Sharing - Pinterest' do

  end

end

