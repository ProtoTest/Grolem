module Pages
  class CheckoutPaymentPage<SitePrism::Page
    set_url "/checkout/payment"
    element :pay_with_paypal_checkbox, '.paypal'
    element :pay_with_credit_card, '.new-credit-card'

    def PayWithPaypal

    end

    def EnterCreditCardInfo name, card, exp_month, exp_year, cvc, save_payment_info?, use_shipping_address?

    end

    def EnterBillingAddress firstname, lastname, address1, address2, city, state, zip, phone

    end
  end
end