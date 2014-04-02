module Pages
  class SalesEvent < SitePrism::Page

    set_url "/sales{/sale}"

    element :sort_by, '.sort-filters em'
    elements :sort_options, ".sort-filters a"
    element :product, "div.product-info"
    elements :prices, '.price em'

    @@sort_type = [:featured, :low_price, :available]


    def SortItems(sort_type_i)
      list_index = @@sort_type.index(sort_type_i)
      puts sort_type_i
      sort_by.click
      sleep(1)
      sort_options[list_index].click
      puts sort_options[list_index]
    end
  end

  def PriceList
    product.all('.price em').map {|price| string_to_price(price.text)}
  end

  private
  def string_to_price(str)
    puts str
    r = /\$([\d,]+)/.match(str)[1].gsub!(',','').to_i
    puts r
    r
  end

end