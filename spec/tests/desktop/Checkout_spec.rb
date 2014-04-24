require 'spec_helper'

require_all 'pages'

include Pages


feature 'Checkout' do

# run this once before all of the scenarios
  before(:all) do
    @rand = rand(1000).to_s
    @email = "testuser" + @rand + "@mailinator.com"
    @password = OKL_USER_PASSWORD
    @firstname = OKL_USER_FIRST_NAME
    @lastname = OKL_USER_LAST_NAME
    @fullname = "#{@firstname} #{@lastname}"
    @item_to_search_for = "lamp"

    @shipping_info = {:first => @firstname,
                      :last => @lastname,
                      :address1 => ADDRESS1,
                      :city => CITY,
                      :state => STATE,
                      :state_abbr => STATE_ABBR,
                      :zip => ZIP,
                      :phone => PHONE}

    @billing_info = {:fullname => @fullname,
                     :credit_card_num => VISA_TEST_CC,
                     :exp_month => CC_EXP_MONTH,
                     :exp_year => CC_EXP_YEAR,
                     :cvc => VISA_TEST_CCV}

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
    @page.header.SearchFor(@item_to_search_for).GoToFirstProduct(:available).AddToCart.VerifyItemAddedToCart

  end

  scenario 'Remove item from cart' do
    @page = HomePage.new
    @page.load
    product_name = @page.header.SearchFor(@item_to_search_for).GoToFirstProduct(:available).AddToCart.VerifyItemAddedToCart

    @page = ShoppingCartPage.new
    @page.RemoveItemFromCart(product_name).VerifyItemRemovedFromCart(product_name)

  end

  scenario 'Check mini cart' do
    @page = HomePage.new
    @page.load
    @page.header.SearchFor(@item_to_search_for).GoToFirstProduct(:available).AddToCart.VerifyItemAddedToMiniCart

  end

  scenario 'Can change quantity' do
    item_quantity = 2

    @page = HomePage.new
    @page.load
    @page.header.SearchFor(@item_to_search_for).GoToFirstProduct(:available).AddToCart.VerifyItemAddedToCart

    @page = ShoppingCartPage.new
    @page.ChangeVerifyItemQuantityUpdated(item_quantity)

  end

  scenario 'Can add new shipping address and new credit card in checkout flow' do
    save_payment_info = true
    use_shipping_address = true

    @page = HomePage.new
    @page.load
    @page.header.SearchFor(@item_to_search_for).
        GoToFirstProduct(:available).
        AddToCart.
        header.GoToCart.
        CheckOutNow.
        EnterShippingDetails(@shipping_info).
        Continue.
        EnterBillingInfo(@billing_info, save_payment_info, use_shipping_address).
        Continue.VerifyAddressAndCreditCardAdded(@shipping_info, @billing_info)

  end

  scenario 'Checkout with saved address and saved credit card in checkout flow' do
    shipping_info_saved = true
    credit_info_saved = true

    @page = HomePage.new
    @page.load
    @page.header.SearchFor(@item_to_search_for).
        GoToFirstProduct(:available).
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
        GoToFirstProduct(:available).
        AddToCart.
        header.GoToCart.
        CheckOutNow(shipping_info_saved, credit_info_saved).
        AddGiftMessage(gift_msg).
        PlaceOrder.VerifyOrderCompleted
  end

  scenario 'Can checkout with PayPal' do
    @page = HomePage.new
    @page.load
    @page.header.SearchFor(@item_to_search_for).
        GoToFirstProduct(:available).
        AddToCart.
        header.GoToCart.
        CheckoutWithPayPal.
        LoginToPayPal.
        CompletePayPalCheckout.
        VerifyPayPalPaymentMethod.
        PlaceOrder.VerifyOrderCompleted

  end

  scenario 'Verify order comes through in AX' do
    shipping_info_saved = true
    credit_info_saved = true

    @page = HomePage.new
    @page.load

    order_id = @page.header.SearchFor(@item_to_search_for).
        GoToFirstProduct(:available).
        AddToCart.
        header.GoToCart.
        CheckOutNow(shipping_info_saved, credit_info_saved).
        PlaceOrder.VerifyOrderCompleted

    if order_id.nil?
      raise "Failed to get the order ID from the confirmation page"
    else
      exec_str = verify_order_in_ax(order_id)

      if not exec_str.include?(order_id.to_s)
        raise "Failed to verify order_id '#{order_id}' came through the AX: exec_output: #{exec_str}"
      end
    end

  end
end

