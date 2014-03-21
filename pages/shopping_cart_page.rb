

module Pages

  class CartRowSection < SitePrism::Section
    element :image_link, '#image-link'
    element :name_link, '#cart-line-data'
    element :delivery_notice, '#virtual-delivery-notice'
    element :return_policy_notice, '#return-policy-notice'
    element :unit_price_label, '#unit-price'
    element :unit_price_label, '#unit-price'
    element :item_quantity_dropdown, 'select[name=quantity]'
    element :total_price_label, '#total-price'
    element :remove_item_link, '#remove-link'
  end

  class ShoppingCartPage < BasePage
    set_url '/cart'
    element :check_out_now_top_button, :xpath, '//header//a[contains(@class,"checkout-btn")]'
    element :item_reservation_duration, '#countdown'
    element :add_offer_code_link, '.addOfferCode'
    element :continue_shopping_link, '#continue-shopping-btn'
    element :exclusions_link, '#ship-promo-exclusions'
    element :subtotal_label, :xpath, 'ul[class=credit-warnings]/d1/dd[1]'
    element :shipping_label, '#shipping'
    element :estimated_tax_label, 'dd[class=totals]'
    element :check_out_now_button, :xpath, '//div[@class="checkout-nav"]/a'
    element :paypal_button, 'img[alt=Btn_xpresscheckout]'
    element :cart_timed_out_message, '.expired-msg'

    elements :remove_links, ".remove-link"

    section :first_item, CartRowSection, :xpath,'//ul[@class="cart-lines"]/li[1]'
    section :second_item, CartRowSection, :xpath, '//ul[@class="cart-lines"]/li[2]'
    section :third_item, CartRowSection, :xpath, '//ul[@class="cart-lines"]/li[3]'

    sections :cart_items, CartRowSection, :xpath, '//ul[@class="cart-lines"]/li'

    def CheckOutNow
      check_out_now_button.click
      CheckoutShippingPage.new
    end

    def VerifyCartEmpty
      empty_cart = 'Your cart is empty'
      find_first(:xpath, "//*[contains(text(),'" + empty_cart + "')]")
      cart_items.size.should == 0
      self
    end

    def RemoveAllItemsFromCart
      num_items = remove_links.size

      num_items.times do
        remove_links.first.click
        ShoppingCartPage.new
      end

      self.VerifyCartEmpty
    end

  end


end
