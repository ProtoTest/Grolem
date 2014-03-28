module Pages
  class MyAccountInformationPage < BasePage
    set_url '/my_account'

    element :add_payment_btn, :xpath, "//ul[contains(@class, 'payment-list')]/li/a"

    def AddPaymentMethod
      add_payment_btn.click

      AddPaymentPage.new
    end

    ##
    # Remove the payment method from the account
    #
    # @param [Hash] billing_info: The billing info hash
    # billing_info = {:fullname,
    #                :credit_card_num,
    #                :exp_month,
    #                :exp_year,
    #                :cvc}
    def RemovePaymentMethod(billing_info)
      xpath_str = "//input[contains(@value, 'Delete') and ../../../../*[contains(text(),'" + billing_info[:credit_card_num][-4,4] + "')]]"
      find_first(:xpath, xpath_str).click

      MyAccountInformationPage.new
    end

    ##
    # Verify billing details were added to the page
    #
    # @param [Hash] billing_info: The billing info hash
    # billing_info = {:fullname,
    #                :credit_card_num,
    #                :exp_month,
    #                :exp_year,
    #                :cvc}
    def VerifyPaymentAdded(billing_info)
      last_4_str = "Last 4 digits: #{billing_info[:credit_card_num][-4,4]}"
      expires_str = "Expires: #{billing_info[:exp_month]}/#{billing_info[:exp_year]}"

      find_first(:xpath, "//*[contains(text(),'" + last_4_str + "')]")
      find_first(:xpath, "//*[contains(text(),'" + expires_str + "')]")
    end

    ##
    # Verify billing details were removed from the page
    #
    # @param [Hash] billing_info: The billing info hash
    # billing_info = {:fullname,
    #                :credit_card_num,
    #                :exp_month,
    #                :exp_year,
    #                :cvc}
    def VerifyPaymentMethodRemoved(billing_info)
      delete_payment_xpath = "//input[contains(@value, 'Delete') and ../../../../*[contains(text(),'" + billing_info[:credit_card_num][-4,4] + "')]]"

      if element_exists?(:xpath, delete_payment_xpath)
        raise "Failed to verify the payment method with last 4 digits '#{billing_info[:credit_card_num][-4,4]}' was removed"
      end

      MyAccountInformationPage.new
    end

  end
end