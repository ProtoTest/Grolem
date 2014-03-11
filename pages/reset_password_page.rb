module Pages
  class ResetPasswordPage <  SitePrism::Page
    element :new_password_field,'#password'
    element :re_enter_password_field, '#confirm'
    element :reset_password_button, 'input[name=submit]'
    element :shop_all_sales_button, :xpath, '//img[contains(@src,""shopAllSales")]'

    def ResetPasswordTo text
      new_password.field.set text
      re_enter_password_field.set text
      reset_password_button.click
      shop_all_sales_button.click
      HomePage.new
    end
  end
end
