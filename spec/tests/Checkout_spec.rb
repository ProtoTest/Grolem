require 'spec_helper'
require_all 'pages'

include Pages


feature 'Checkout' do

# run this once before all of the scenarios
  before(:all) do
    @rand = rand(1000).to_s
    #@email = "testuser" + @rand + "@mailinator.com"
    @email = "msiwiec@mailinator.com"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'

# register the user
    #register_user(@firstname, @lastname, @password, @email)

  end

  before(:each) do
    @page = login(@email, @password)
    remove_all_items_from_cart
  end

  after(:each) do
  end



  scenario 'Verify shopping cart is initially empty' do
    @page.header.GoToCart.VerifyCartEmpty
  end

  scenario 'Add item to cart' do
    @page.header.SearchFor("item").GoToFirstProduct.AddToCart
  end


=begin
  scenario 'Remove item from cart' do

  end

  scenario 'Check mini cart' do

  end

  scenario 'Can change quantity' do
    @page

  end

  scenario 'Can add new shipping address in checkout flow' do

  end

  scenario 'Can checkout with new credit card' do
    @page

  end

  scenario 'Checkout with saved address in checkout flow' do
    @page

  end

  scenario 'Can checkout with with saved credit card' do
    @page

  end

  scenario 'Checkout with gift message' do
    @page

  end

  scenario 'Can checkout with PayPal' do
    @page

  end

  scenario 'Verify order comes through in AX' do
    @page

  end

  scenario 'Cart expires after 10 minutes idle' do
    @page

  end
=end
end
