
module Pages
  class CheckoutPaymentPage<BasePage
    set_url "/checkout/payment"
    element :pay_with_paypal_checkbox, '.paypal'

    # the following are if you are NOT using paypal
    element :pay_with_credit_card, '.new-credit-card'
    element :card_name_field, '#cardholder-name-input'
    element :card_number_field, '#okl_customer_client_v1_payment_card_card_number'
    element :card_exp_month_dropdown, '#expire-month'
    element :card_exp_year_dropdown, '#expire-year'
    element :card_cvc_field, '#security-code'

    element :save_payment_info, '#save-payment-info'
    element :use_shipping_address, '#use-shipping-address'

    element :first_name_field, '.js-firstname'
    element :last_name_field, 'js-lastname'
    element :address1_field, 'js-address1'
    element :address2_field, 'js-address2' # optional
    element :city_field, 'js-city'
    element :zip_field, 'js-js-postcode'
    element :state_dropdown, '#okl_customer_client_v1_payment_card_billing_address_attributes_state'
    element :phone_field, '.js-phone'

    element :continue_btn, :xpath, "//*[contains(text(),'CONTINUE')]"

    def PayWithPaypal

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
      self.card_name_field.set billing_info[:fullname]
      self.card_number_field.set billing_info[:credit_card_num]
      self.card_exp_month_dropdown.select billing_info[:exp_month]
      self.card_exp_year_dropdown.select billing_info[:exp_year]
      self.card_cvc_field.set billing_info[:cvc]
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
      self.first_name_field.set address[:first]
      self.last_name_field.set address[:last]
      self.address1_field.set address[:address1]
      self.address2_field.set address[:address2] if address[:address2]
      self.city_field.set address[:city]
      self.state_dropdown.select address[:state]
      self.zip_field.set address[:zip]
      self.phone_field.set address[:phone]

      CheckoutPaymentPage.new
    end

    def Continue
      self.continue_btn.click

      ReviewOrderPage.new
    end
  end
end