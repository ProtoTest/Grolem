require 'site_prism'

module Pages
  class SearchResultsPage < SitePrism::Page
  element :search_results_summary, '.search-results-summary'
  element :sort_dropdown, '.sort-dropdown'
  element :sort_option_relevance, '.sort-featured'
  element :sort_option_lowest_price, '.sort-price_low'
  element :sort_option_highest_price, '.sort-price_high'
  element :category_toggle, '.category-filter'
  element :first_product, '.standard'

  set_url "/search{?query*}"


    def GoToFirstProduct
      first_product.click
      ProductPage.new
    end
  end
end
