module Sections
  class MobileCartItem<BaseSection
    element :item_logo, 'figure.prd-image'
    element :item_title_label, 'section.prd-details'
    element :item_cost_label, 'p.prd-okl-price'
    element :delivery_label, 'li.virtual-delivery-notice'
    element :quantity_dropdown, 'select[name=quantity]'
    element :remove_button, 'a',:text=>"Remove"
  end
end


module Pages
  class MobileCartPage<BasePage
    element :back_button, 'li.back-command'
    element :cart_timer_label, 'abbr.timer'
    element :check_out_button, 'li.checkout-btn'
    element :pay_with_creditcard_button, 'a.tgl-choice',:text=>'Credit Card'
    element :pay_with_paypal_button, 'a.tgl-choice',:text=>'PayPal'

    element :subtotal_label, :xpath, '//tr[./td[text()="Subtotal"}]/td[@class="cost-item"]'
    element :shipping_label, :xpath, '//tr[./td[text()="Shipping"}]/td[@class="cost-item"]'
    element :estimated_tax_label, :xpath, '//tr[./td[text()="Estimated Tax"}]/td[@class="cost-item"]'
    element :order_total_label, :xpath, '//tr[@class="total"]/td[@class="cost-item"]'
    element :apply_gift_card_button, 'div.offer-code'

    sections :cart_items, MobileCartItem, 'li.cart-line'

    def GoToCheckout
      check_out_button.click
      MobileCheckoutPage.new
    end
  end
end