module Pages
  class ReviewOrderPage < SitePrism::Page
    set_url '/checkout/review'

    element :shipping_name, '.shippingName'
    element :shipping_address1, '.shippingAddress'
    element :shipping_address2, '' # site is reusing the class name '.shippingAddress for city, state, zip (not unique)
    element :phone, '.phoneNumber'
    element :change_address_btn, :xpath, "//ul[@id='shippingAddressMenu']/li/button"
    element :change_payment_btn, :xpath, "//a[text()='Change']"
    element :place_order_btn, :xpath, "//*[contains(text(),'Place your order')]"

    # Gift message related
    element :add_gift_msg, '#editMessage'
    element :gift_msg_textarea, '#giftMessageText'
    element :gift_msg_done_btn, '#submitGiftMessage'

    def wait_for_elements
      wait_until_order_thank_you_visible
      products.size.should > 0
    end

    def AddGiftMessage(msg)
      add_gift_msg.click
      wait_until_gift_msg_textarea_visible
      wait_until_gift_msg_done_btn_visible
      gift_msg_textarea.set msg
      gift_msg_done_btn.click
      find_first(:xpath, "//*[contains(text(),'" + msg + "')]")

      ReviewOrderPage.new
    end


    def ChangeAddShippingDetails(shipping_info)
      change_address_btn.click
      CheckoutShippingPage.new.EnterShippingDetails(shipping_info)

      ReviewOrderPage.new
    end

    def ChangePaymentMethod(billing_info, save_payment_info, use_shipping_address)
      change_payment_btn.click
      CheckoutPaymentPage.new.
          EnterBillingInfo(billing_info, save_payment_info, use_shipping_address).
          Continue

      ReviewOrderPage.new
    end

    def PlaceOrder
      place_order_btn.click

      OrderCompletedPage.new
    end
  end
end