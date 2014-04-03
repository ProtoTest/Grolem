module Sections
  class WhiteGloveSection < BaseSection

  end
end

module Pages
  class ProductPage<BasePage
    attr_reader :header, :qty_options, :size_options, :product_qty_select, :product_size_select

    include Sections
    set_url '/product/33381/1909101'
    element :product_image, '.productImage'
    element :add_to_cart_button, '.addToCart'
    element :product_name, :xpath, "//h1[@class='serif']"
    element :product_price, '#oklPriceLabel'
    element :product_qty_select, '#selectSkuQuantity'
    element :product_size_select, '.productOptionSelect'
    section :header, Sections::LoggedInHeader, '.okl-header'

    # quantity and size options
    elements :qty_options, '.qty'
    elements :size_options, '.opt'

    def AddToCart(qty=nil)
      product_txt = product_name.text(:visible)
      product_qty_select.select(qty) if qty
      add_to_cart_button.click

      header.WaitForMicroCartToDisplay

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

    def UpdateSizeQty(size, qty)
      product_size_select.select(size) if size
      product_qty_select.select(qty) if qty

      ProductPage.new
    end

    def VerifySearchElements
      self.header.should be_all_there
    end
  end
end
