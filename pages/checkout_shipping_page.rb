
module Pages
  class CheckoutShippingPage < SitePrism::Page
    element :first_name_field, '#firstname'
    element :last_name_field, '#lastname'
    element :address_field, '#address1'
    element :address_line2_field, '#address2'
    element :city_field, '#city'
    element :state_dropdown, '#zone'
    element :zipcode_field, '#postcode'
    element :phone_number_field, '#phonenumber'
    element :continue_btn, :xpath, "//input[@value='Continue >']"
    set_url '/checkout/address'

    def EnterAddress firstname, lastname, address, city, state, zip, phone
      # if none of these elements are present, the address information has most likely already been
      # entered into the system and saved
      if all_there?
        first_name_field.set firstname
        last_name_field.set lastname
        address_field.set address
        city_field.set city
        state_dropdown.select state
        zipcode_field.set zip
        phone_number_field.set phone
        continue_btn.click
      end

      CheckoutPaymentPage.new
    end
  end
end
