module Pages
  class ResetPasswordPage <  BasePage
    set_url ''
    element :new_password_field,'#password'
    element :re_enter_password_field, '#confirm'
    element :reset_password_button, 'input[value=reset]'
    element :shop_all_sales_button, :xpath, '//img[contains(@src,"shopAllSales")]'

    def ResetPasswordTo text
      new_password_field.set text
      re_enter_password_field.set text
      reset_password_button.click
      shop_all_sales_button.click
      HomePage.new
    end
  end
end
