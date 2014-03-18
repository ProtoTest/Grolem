require 'spec_helper'
require_all 'pages'

include Pages

feature 'Checkout' do

# run this once before all of the scenarios
  before(:all) do
    @rand = rand(1000).to_s
    @email = "testuser" + @rand + "@mailinator.com"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'

# register the user
    @page = SignupModal.new
    @page.load

    @page.EnterEmail(@email).
        EnterInfo(@firstname,@lastname,@password).ClosePanel

    @initialized = true
  end

  before(:each) do
    set_url config.default_url + "/login" if @initialized
    @page.load
  end

  scenario 'Add item to cart' do

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

