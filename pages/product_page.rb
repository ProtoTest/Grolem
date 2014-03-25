require './sections/logged_in_header'

module Pages
  class ProductPage<BasePage
    attr_reader :header

    include Sections
    set_url '/product/33381/1909101'
    element :product_image, '.productImage'
    element :item_quantity_dropdown, '#selectSkuQuantity'
    element :add_to_cart_button, '.addToCart'
    element :product_name, :xpath, "//h1[@class='serif']"
    element :product_price, '#oklPriceLabel'
    element :product_qty_select, '#selectSkuQuantity'
    section :header, Sections::LoggedInHeader, '.okl-header'

    def AddToCart(qty=nil)
      product_txt = product_name.text(:visible)
      product_qty_select.select(qty) if qty
      add_to_cart_button.click

      ProductPage.new
    end

    def VerifyItemAddedToCart
      product_txt = product_name.text(:visible)
      cart = ShoppingCartPage.new
      cart.load
      cart.VerifyItemsInCart [product_txt]

      product_txt
    end

    def VerifyItemAddedToMiniCart
      product_txt = product_name.text(:visible)
      header.mini_cart.VerifyItemInMiniCart(product_txt)
    end
  end
end
