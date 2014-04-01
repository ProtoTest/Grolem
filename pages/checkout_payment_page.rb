
module Pages
  class CheckoutPaymentPage<BasePage
    set_url "/checkout/payment"

    # paypal only
    element :pay_with_paypal_radio, '.paypal'

    # the following are if you are NOT using paypal
    section :payment_info, AddPaymentSection, '#new_okl_customer_client_v1_payment_card'
    element :save_payment_info, '#save-payment-info'
    element :use_shipping_address, '#use-shipping-address'
    element :continue_btn, :xpath, "//*[contains(text(),'CONTINUE')]"

    def wait_for_elements
      wait_until_continue_btn_visible

      self
    end

    def PayWithPaypal
      pay_with_paypal_radio.click
      continue_btn.click

      PayPalPage.new
    end

    ##
    # Enter billing details into the form
    #
    # @param [Hash] billing_info: The billing info hash
    # billing_info = {:fullname,
    #                :credit_card_num,
    #                :exp_month,
    #                :exp_year,
    #                :cvc}
    # @param [Boolean] save_payment_info: To save the payment information in the system
    # @param [Boolean] use_shipping_address: To set the billing address as the shipping address
    def EnterBillingInfo(billing_info, save_payment_info, use_shipping_address)
      payment_info.EnterPaymentInfo(billing_info)

      self.save_payment_info.set_checked(save_payment_info)
      self.use_shipping_address.set_checked(use_shipping_address)

      CheckoutPaymentPage.new
    end


    ##
    # Enter the billing address and phone into the form
    # @param [Hash] address: A hash containing the address information
    # address = {:first,
    #            :last,
    #            :address1,
    #            :address2, #optional
    #            :city,
    #            :state,
    #            :zip,
    #            :phone}
    def EnterBillingAddressAndPhone(address)
      payment_info.EnterPaymentAddressAndPhone(address)
      CheckoutPaymentPage.new
    end

    def Continue
      self.continue_btn.click

      ReviewOrderPage.new
    end
  end
end