module Sections
  class WhiteGloveToolTip < BaseSection
    element :close_btn, '.close'
    element :title, '.title', :text => 'White glove & home delivery shipping rate'
  end

  class WhiteGloveSection < BaseSection
    element :main_label, :xpath, "./dt[2]"
    element :icon, :xpath, "./dt[2]/img[contains(@src, 'whiteglove.gif')]"
    element :description, :xpath, "./dd[2]"
    element :tool_tip_link, :xpath, "./dd[2]/a[contains(@class, 'shippingTooltip')]"
  end

  class VMFVendorSection < BaseSection
    element :vendor_name, 'div h5'
    element :vendor_description, 'div p'
    element :vendor_page_link, 'a', :text=>"See seller's other items"
  end
end

module Pages
  class ProductPage<BasePage
    attr_reader :header, :qty_options, :size_options, :product_qty_select, :product_size_select
    attr_reader :white_glove_section, :vmf_vendor_section

    include Sections
    set_url '/product/33381/1909101'
    element :product_image, '.productImage'
    element :add_to_cart_button, '.addToCart'
    element :product_name, :xpath, "//h1[@class='serif']"
    element :product_price, '#oklPriceLabel'
    element :product_qty_select, '#selectSkuQuantity'
    element :product_size_select, '.productOptionSelect'
    section :header, Sections::LoggedInHeader, '.okl-header'

    # white glove: not always displayed. Depends on whether or not the product has 'extra'
    # special shipping requirements
    section :white_glove_section, WhiteGloveSection, :xpath, "//dl[contains(@class,'shippingDetails')]"

    # present, but not visible until tool_tip_link is clicked
    section :tool_tip_modal, WhiteGloveToolTip, "#productShipping"

    # vintage seller info
    section :vmf_vendor_section, VMFVendorSection, '.ds-vmf-vendor'

    # quantity and size options
    elements :qty_options, '.qty'
    elements :size_options, '.opt'

    def AddToCart(qty=nil)
      product_txt = product_name.text(:visible)
      product_qty_select.select(qty) if qty
      add_to_cart_button.click

      header.WaitForMicroCartToDisplay

      ProductPage.new
    end

    def VerifyItemAddedToCart
      product_txt = product_name.text(:visible)
      cart = ShoppingCartPage.new
      cart.load
      cart.VerifyItemsInCart [product_txt]

      product_txt
    end

    def VerifyItemAddedToMiniCart
      product_txt = product_name.text(:visible)
      header.mini_cart.VerifyItemInMiniCart(product_txt)
    end

    def UpdateSizeQty(size, qty)
      product_size_select.select(size) if size
      product_qty_select.select(qty) if qty

      ProductPage.new
    end

    def VerifySearchElements
      self.header.should be_all_there
    end

    # Applies to only VMF products
    def GoToVMFVendorPage
      vmf_vendor_section.vendor_page_link.click

      ShopByVendorPage.new
    end
  end
end
