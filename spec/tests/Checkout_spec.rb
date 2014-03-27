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
    @fullname = "#{@firstname} #{@lastname}"
    @item_to_search_for = "lamp"

    # register the user
    register_user(@firstname, @lastname, @password, @email)

  end

  before(:each) do
    @page = login(@email, @password)

    # Cleanup
    remove_all_items_from_cart
  end

  after(:each) do

  end

  scenario 'Verify shopping cart is initially empty' do
    @page.header.GoToCart.VerifyCartEmpty
  end

  scenario 'Add item to cart' do
    @page = HomePage.new
    @page.load
    @page.header.SearchFor(@item_to_search_for).GoToFirstProductNotSoldOutOnHold.AddToCart.VerifyItemAddedToCart

  end

  scenario 'Remove item from cart' do
    @page = HomePage.new
    @page.load
    product_name = @page.header.SearchFor(@item_to_search_for).GoToFirstProductNotSoldOutOnHold.AddToCart.VerifyItemAddedToCart

    @page = ShoppingCartPage.new
    @page.RemoveItemFromCart(product_name).VerifyItemRemovedFromCart(product_name)

  end

  scenario 'Check mini cart' do
    @page = HomePage.new
    @page.load
    @page.header.SearchFor(@item_to_search_for).GoToFirstProductNotSoldOutOnHold.AddToCart.VerifyItemAddedToMiniCart

  end

  scenario 'Can change quantity' do
    item_quantity = 4

    @page = HomePage.new
    @page.load
    @page.header.SearchFor(@item_to_search_for).GoToFirstProductNotSoldOutOnHold.AddToCart.VerifyItemAddedToCart

    @page = ShoppingCartPage.new
    @page.ChangeVerifyItemQuantityUpdated(item_quantity)

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
    @page.header.SearchFor(@item_to_search_for).
        GoToFirstProductNotSoldOutOnHold.
        AddToCart.
        header.GoToCart.
        CheckOutNow.
        EnterShippingDetails(shipping_info).
        Continue.
        EnterBillingInfo(billing_info, save_payment_info, use_shipping_address).
        Continue.VerifyAddressAndCreditCardAdded(shipping_info, billing_info)

  end

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
    @page.header.SearchFor(@item_to_search_for).
        GoToFirstProductNotSoldOutOnHold.
        AddToCart.
        header.GoToCart.
        CheckOutNow(shipping_info_saved, credit_info_saved).
        PlaceOrder.VerifyOrderCompleted

  end

  scenario 'Checkout with gift message' do
    shipping_info_saved = true
    credit_info_saved = true
    gift_msg = "I love you man"

    @page = HomePage.new
    @page.load
    @page.header.SearchFor(@item_to_search_for).
        GoToFirstProductNotSoldOutOnHold.
        AddToCart.
        header.GoToCart.
        CheckOutNow(shipping_info_saved, credit_info_saved).
        AddGiftMessage(gift_msg).
        PlaceOrder.VerifyOrderCompleted

    sleep 4

  end

  scenario 'Can checkout with PayPal' do
    @page = HomePage.new
    @page.load
    @page.header.SearchFor(@item_to_search_for).
        GoToFirstProductNotSoldOutOnHold.
        AddToCart.
        header.GoToCart.
        CheckoutWithPayPal.
        LoginToPayPal.
        CompletePayPalCheckout.
        VerifyPayPalPaymentMethod.
        PlaceOrder.VerifyOrderCompleted

  end
=begin
  scenario 'Verify order comes through in AX' do
    @page

  end

  # this case is implemented in 'session_spec.rb'
  scenario 'Cart expires after 10 minutes idle' do

  end
=end
end

