require 'site_prism'

module Pages
  class ShoppingCartPage < SitePrism::Page
    set_url '/cart'
    element :check_out_now_top_button, 'header/.okl-btn'
    element :check_out_now_button_button, '.checkout-nav-container/.okl-btn'
  end
end
