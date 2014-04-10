module Sections
  include Pages
  class MobileHeader < BaseSection
    element :menu_button, 'p.menu'
    element :back_button, 'p.back'
    element :cart_button, 'p.cart'
    element :okl_logo, 'h1.page-title'
    def GoHome
      okl_logo.click
      self
    end
    def GoBack
      back_button.click
      self
    end



    def GoToLogin
      GoHome
      menu_button.click
      LoginPage.new
    end

    def GoToCart
      cart_button.click
      ShoppingCartPage.new
    end
  end
end