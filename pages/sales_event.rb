module Pages
  class SalesEvent < SitePrism::Page

    set_url "/sales{/sale}"

    element :sort_by, '.sort-filters em'
    elements :sort_options, '.sort-filters a'
    elements :products, 'li.product'
    elements :prices, '.price em'
    section :header, LoggedInHeader, '.okl-header'
    section :footer, LoggedInFooter, '#footer'


    @@sort_type = [:featured, :low_price, :available]

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