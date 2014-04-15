module Pages
  class MobileOrderCompletedPage < SitePrism::Page

    element :close_btn, 'a', :text => 'Close'
    element :order_thank_you, :xpath, "//*[contains(text(),'Thank You!')]"
    element :order_number, '.order-id'
    elements :products, 'li.cart-line'

    def VerifyOrderCompleted
      wait_until_order_thank_you_visible
      products.size.should > 0
    end


  end
end