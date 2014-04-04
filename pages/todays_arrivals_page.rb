require 'site_prism'

# Vintage Market Finds
module Pages
  class TodaysArrivalsPage < BasePage
    attr_reader :header
    set_url ''

    element :first_product_link, :xpath, "//li[@class='product sortable']/a"

    section :header, LoggedInHeader, '.okl-header'

    def GoToFirstProduct
      first_product_link.click
      ProductPage.new
    end
  end
end
