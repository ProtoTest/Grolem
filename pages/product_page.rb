require './sections/logged_in_header'

module Pages
  class ProductPage<BasePage
    include Sections
    set_url '/product/33381/1909101'
    element :product_image, '.productImage'
    element :item_quantity_dropdown, '#selectSkuQuantity'
    element :add_to_cart_button, '.addToCart'
    element :product_name, :xpath, "//h1[@class='serif']"
    element :product_price, '#oklPriceLabel'
    element :product_qty_select, '#selectSkuQuantity'
    section :header, Sections::LoggedInHeader, '.okl-header'

    def AddToCart
      $logger.Log "#{product_price.text}"
      product_txt = product_name.text(:visible)
      $logger.Log "#{product_txt}"
      add_to_cart_button.click

      self
    end

    def VerifyItemAddedToCart
      product_txt = product_name.text(:visible)
      cart = ShoppingCartPage.new
      cart.load
      cart.VerifyItemsInCart [product_txt]

      product_txt
    end
  end
end
