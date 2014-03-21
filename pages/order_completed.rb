module Pages
  class OrderCompletedPage < SitePrism::Page

    element :order_thank_you, :xpath, "//*[contains(text(),'THANK YOU FOR YOUR ORDER')]"
    elements :products, '.productName'

    def VerifyOrderCompleted
      wait_until_order_thank_you_visible
      products.size.should > 0
    end


  end
end