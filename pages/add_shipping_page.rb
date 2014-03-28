module Pages
  class AddShippingPage < BasePage
    element :save_btn, :xpath, "//input[contains(@value, 'Save')]"
    element :cancel_btn, '.cancel-btn'

    section :add_shipping_section, AddShippingSection, '#new_okl_customer_client_v1_shipping_address'

    ##
    # Enter the shipping details into the form
    # @param [Hash] shipping_info: A hash containing the shipping address and phone
    # shipping_info = {:first,
    #                  :last,
    #                  :address1,
    #                  :address2, #optional
    #                  :city,
    #                  :state,
    #                  :state_abbr,
    #                  :zip,
    #                  :phone}
    def EnterShippingDetails(shipping_info)
      add_shipping_section.EnterShippingDetails(shipping_info)

      AddShippingPage.new
    end

    def SaveShippingInfo
      save_btn.click

      MyAccountInformationPage.new
    end

    def Cancel
      cancel_btn.click

      MyAccountInformationPage.new
    end
  end
end