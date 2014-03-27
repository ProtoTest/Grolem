module Pages
  class MyAccountInformationPage < BasePage
    set_url '/my_account'

    element :add_payment_btn, :xpath, "//ul[contains(@class, 'payment-list')]/li/a"

    def AddPaymentMethod
      add_payment_btn.click

      AddPaymentPage.new
    end
  end
end