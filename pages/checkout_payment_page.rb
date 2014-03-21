module Pages
  class CheckoutPaymentPage<BasePage
    set_url "/checkout/payment"
    element :pay_with_paypal_checkbox, '.paypal'
    element :pay_with_credit_card, '.new-credit-card'

  end
end