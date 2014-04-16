module Sections
  class ItemAddedDialogSection < BaseSection
    element :text, 'p'
    element :continue_btn, 'a', :text => 'Continue'
    element :checkout_btn, 'a', :text => 'Checkout'
  end

  class WhiteGloveSection < BaseSection
    element :main_label, :xpath, ".//dt[2 and contains(text(), 'White Glove')]"
    element :description, :xpath, ".//dd[2 and contains(text(), 'Additional shipping fee for delivery')]"
  end
end

module Pages
  class MobileProductPage<BasePage
    attr_reader :shipping_returns_section, :white_glove_section

    element :product_image, 'ul.slides'
    element :product_name, 'h2.product-name'
    element :our_price_label, 'span.outs'
    element :retail_price_label, 'span.msrp'
    element :quantity_dropdown, 'select[name=quantity]'
    element :size_dropdown, 'select[name=skuId]'
    element :add_to_cart_button, 'button.add-to-cart'
    element :product_details_section, 'section.details a'
    element :shipping_returns_section, 'section.shipping a'
    element :description_section, 'section.description a'
    element :share_section, 'section.sharing a'
    element :facebook_button, 'li.facebook a'
    element :pinterest_button, 'li.pinterest a '
    elements :size_options, '.opt'
    section :item_added_modal_section, ItemAddedDialogSection, 'div.dialog'

    # white glove: not always displayed. Depends on whether or not the product has 'extra'
    # special shipping requirements
    section :white_glove_section, WhiteGloveSection, '#product-shipping'

    def ShareViaFacebook(facebook_email, facebook_password, msg=nil)

      product_name_str = product_name.text

      share_section.click
      facebook_button.click
      sleep 1

      new_window = page.driver.browser.window_handles.last

      page.within_window new_window do
        MobileFacebookLoginPage.new.LoginToShare(facebook_email, facebook_password).
            VerifyProductNameDisplayed(product_name_str).ShareLink(msg)
      end

      product_name_str
    end

    def ShareViaPinterest(facebook_email, facebook_password)
      product_name_str = product_name.text

      share_section.click
      pinterest_button.click
      sleep 1

      new_window = page.driver.browser.window_handles.last

      page.within_window new_window do
        PinterestPage.new.LoginToShare(facebook_email, facebook_password).PinIt
      end

      product_name_str
    end

    def SelectQuantity num
      quantity_dropdown.click
      quantity_dropdown.select num
      self
    end

    def SelectSize text
      size_dropdown.click
      size_dropdown.select text
      self
    end

    def SelectSizeByIndex index
      size_dropdown.click
      size_dropdown.select index
      self
    end

    def AddToCart
      add_to_cart_button.click

      wait_until_item_added_modal_section_visible

      self
    end

    def ItemAddedModal_Continue
      item_added_modal_section.continue_btn.click
      wait_until_item_added_modal_section_invisible
      MobileSalesEventPage.new
    end

    def ItemAddedModal_Checkout
      item_added_modal_section.checkout_btn.click
      MobileCartPage.new
    end

    def VerifyItemAddedToCart
      product_txt = product_name.text(:visible)
      cart = MobileCartPage.new
      cart.load
      cart.VerifyItemsInCart [product_txt]

      product_txt
    end
  end
end