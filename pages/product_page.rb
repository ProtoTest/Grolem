require './sections/logged_in_header'

module Pages
  class ProductPage<SitePrism::Page
    include Sections
    set_url '/product/33381/1909101'
    element :product_image, '.productImage'
    element :item_quantity_dropdown, '#selectSkuQuantity'
    element :add_to_cart_button, '.addToCart'
    section :header, Sections::LoggedInHeader, '.okl-header'

    def AddToCart
      add_to_cart_button.click
      self
    end
  end
end
