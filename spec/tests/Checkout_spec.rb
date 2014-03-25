require 'spec_helper'
require_all 'pages'

include Pages


feature 'Checkout' do

# run this once before all of the scenarios
  before(:all) do
    @rand = rand(1000).to_s
    #@email = "testuser" + @rand + "@mailinator.com"
    #@email = "msiwiec@mailinator.com"
    @email = "testuser207@mailinator.com"
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

  end
=begin
  scenario 'Verify shopping cart is initially empty' do
    @page.header.GoToCart.VerifyCartEmpty
  end

  scenario 'Add item to cart' do
    @page = HomePage.new
    @page.load
    @page.header.SearchFor("lamp").GoToFirstProductNotSoldOut.AddToCart.VerifyItemAddedToCart

    # Cleanup
    remove_all_items_from_cart
  end

  scenario 'Remove item from cart' do
    @page = HomePage.new
    @page.load
    product_name = @page.header.SearchFor("lamp").GoToFirstProductNotSoldOut.AddToCart.VerifyItemAddedToCart

    @page = ShoppingCartPage.new
    @page.RemoveItemFromCart(product_name).VerifyItemRemovedFromCart(product_name)

    # Cleanup
    remove_all_items_from_cart
  end

  scenario 'Check mini cart' do
    @page = HomePage.new
    @page.load
    @page.header.SearchFor("lamp").GoToFirstProductNotSoldOut.AddToCart.VerifyItemAddedToMiniCart

    # Cleanup
    remove_all_items_from_cart
  end

  scenario 'Can change quantity' do
    item_quantity = 4

    @page = HomePage.new
    @page.load
    @page.header.SearchFor("lamp").GoToFirstProductNotSoldOut.AddToCart.VerifyItemAddedToCart

    @page = ShoppingCartPage.new
    @page.ChangeVerifyItemQuantityUpdated(item_quantity)

    # Cleanup
    remove_all_items_from_cart
  end

  scenario 'Can add new shipping address and new credit card in checkout flow' do
    save_payment_info = true
    use_shipping_address = true

    shipping_info = {:first => @firstname,
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

    @page = HomePage.new
    @page.load
    @page.header.SearchFor("lamp").
        GoToFirstProduct.
        AddToCart.
        header.GoToCart.
        CheckOutNow.
        EnterShippingDetails(shipping_info).
        Continue.
        EnterBillingInfo(billing_info, save_payment_info, use_shipping_address).
        Continue.VerifyAddressAndCreditCardAdded(shipping_info, billing_info)

    # Cleanup
    remove_all_items_from_cart
  end
=end

  scenario 'Checkout with saved address and saved credit card in checkout flow' do
    billing_info = {:fullname => @fullname,
                    :credit_card_num => $VISA_TEST_CC,
                    :exp_month => "1",
                    :exp_year => "2020",
                    :cvc => "123"}

    shipping_info_saved = true
    credit_info_saved = true

    @page = HomePage.new
    @page.load
    @page.header.SearchFor("item").
        GoToFirstProduct.
        AddToCart.
        header.GoToCart.
        CheckOutNow(shipping_info_saved, credit_info_saved).
        PlaceOrder.VerifyOrderCompleted
  end

=begin
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

