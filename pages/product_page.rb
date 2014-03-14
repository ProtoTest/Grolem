class ProductPage < SitePrism::Page
  set_url '/product/33381/1909101'
  element :product_image, '.productImage'
  element :item_quantity_dropdown, '#selectSkuQuantity'
  element :add_to_cart_button, '.addToCart'

  def AddToCart
    add_to_cart_button.click
    self
  end
end