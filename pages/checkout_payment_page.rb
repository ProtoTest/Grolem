
module Pages
  class CheckoutPaymentPage<SitePrism::Page
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

    def EnterCreditCardInfo(name, card_number, exp_month, exp_year, cvc, save_payment_info, use_shipping_address)
      self.card_name_field.set name
      self.card_number_field.set card_number
      self.card_exp_month_dropdown.select exp_month
      self.card_exp_year_dropdown.select exp_year
      self.card_cvc_field.set cvc
      self.save_payment_info.set_checked(save_payment_info)
      self.use_shipping_address.set_checked(use_shipping_address)

      self
    end

    def EnterBillingAddress(firstname, lastname, address1, address2, city, state, zip, phone)
      self.first_name_field.set firstname
      self.last_name_field.set lastname
      self.address1_field.set address1
      self.address2_field.set address2
      self.city_field.set city
      self.state_dropdown.select state
      self.zip_field.set zip
      self.phone_field.set phone
    end

    def SubmitBillingInfo
      self.continue_btn.click
    end

  end
end