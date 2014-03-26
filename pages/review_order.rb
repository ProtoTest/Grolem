module Pages
  class ReviewOrderPage < SitePrism::Page
    set_url '/checkout/review'

    element :shipping_name, :xpath, "//div[@id='shippingAddressContent']/ul/li[@class='selected']/p[1]"
    element :shipping_address, :xpath, "//div[@id='shippingAddressContent']/ul/li[@class='selected']/p[2]"
    element :city_state_zip, :xpath, "//div[@id='shippingAddressContent']/ul/li[@class='selected']/p[3]"
    element :phone, :xpath, "//div[@id='shippingAddressContent']/ul/li[@class='selected']/p[4]"
    element :change_address_btn, :xpath, "//ul[@id='shippingAddressMenu']/li/button"

    element :cc_last_four_lbl, :xpath, "//div[contains(@class,'billingInfo')]/p" # <Card> ending in xxxx
    element :cc_expires_lbl, :xpath, "//div[contains(@class,'billingInfo')]" # Expires xx/xxxx
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

      # wait for the modal to disappear
      wait_until_gift_msg_textarea_invisible

      # verify the gift message was added to the form
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

    def VerifyAddressAndCreditCardAdded(shipping_info, billing_info)
      raise "Failed to verify '#{billing_info[:fullname]}' displayed" if not shipping_name.text.eql?(billing_info[:fullname])
      raise "Failed to verify '#{shipping_info[:address1]}' displayed" if not shipping_address.text.eql?(shipping_info[:address1])


      c_s_z_str = "#{shipping_info[:city]}, #{shipping_info[:state_abbr]} #{shipping_info[:zip]}"
      raise "Failed to verify '#{}' displayed" if not city_state_zip.text.eql?(c_s_z_str)
      cc_num = billing_info[:credit_card_num]
      exp_month = billing_info[:exp_month]
      exp_month = "0" + billing_info[:exp_month] if billing_info[:exp_month].length
      exp_year = billing_info[:exp_year]

      cc_lbl_txt = "Visa ending in #{cc_num[-4,4]}"
      exp_lbl_txt = "Expires #{exp_month}/#{exp_year}"

      raise "Failed to verify '#{cc_lbl_txt}' displayed" if not cc_last_four_lbl.text.eql?(cc_lbl_txt)

      self
    end

    def PlaceOrder
      wait_until_place_order_btn_visible
      place_order_btn.click

      OrderCompletedPage.new
    end
  end
end