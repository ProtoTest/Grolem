

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

  class ShoppingCartPage < SitePrism::Page
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

    section :first_item, CartRowSection, :xpath,'//ul[@class="cart-lines"]/li[1]'
    section :second_item, CartRowSection, :xpath, '//ul[@class="cart-lines"]/li[2]'
    section :third_item, CartRowSection, :xpath, '//ul[@class="cart-lines"]/li[3]'

    def CheckOutNow
      check_out_now_button.click
      CheckoutShippingPage.new
    end
  end


end
