module Pages
  class MobileSalesEventPage < SitePrism::Page

    set_url "/sales{/sale}"

    element :sort_by, '.sort-filters em'
    elements :sort_options, '#product-sort'
    elements :products, :xpath, "//li[contains(@id,'product-tile')]"
    elements :prices, '.okl-price'
    section :header, MobileHeader, '.page-header'
    section :footer, MobileFooter, '.page-footer'


    @@sort_type = [:featured, :low_price, :available]

    def initialize(text=nil)
      @text = text if not text.nil?
    end

    def SortItems(sort_type_i)
      list_index = @@sort_type.index(sort_type_i)
      wait_for_sort_by
      sort_by.click
      wait_for_sort_options
      sort_options[list_index].click
    end
  end

  def PriceList
    prices.map { |price| string_to_price(price.text) }
  end

  private
  def string_to_price(str)
    /\$([\d,]+)/.match(str)[1].gsub(',', '').to_i
  end

end