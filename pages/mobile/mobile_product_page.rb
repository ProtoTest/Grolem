module Pages
  class MobileProductPage<BasePage
    element :product_image, 'ul.slides'
    element :our_price_label, 'span.outs'
    element :retail_price_label, 'span.msrp'
    element :quantity_dropdown, 'select[name=quantity]'
    element :add_to_cart_button, 'button.add-to-cart'
    element :product_details_section, 'section.details'
    element :shipping_returns_section, 'section.shipping'
    element :description_section, 'section.description'
    element :share_section, 'section.sharing'


    def SelectQuantity num
      quantity_dropdown.click
      quantity_dropdown.select num
      self
    end

    def AddToCart
      add_to_cart_button.click
      self
    end


  end
end