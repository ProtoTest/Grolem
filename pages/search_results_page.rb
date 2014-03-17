require 'site_prism'

module Pages
  class SearchResultsPage < SitePrism::Page
  element :query_phrase, '.query_phrase'
  element :search_results_summary, '.search-results-summary'
  element :sort_dropdown, '.sort-dropdown'
  element :sort_option_relevance, '.sort-featured'
  element :sort_option_lowest_price, '.sort-price_low'
  element :sort_option_highest_price, '.sort-price_high'
  element :category_filter, '.category-filter'
  element :color_filter, '.color-filter'
  element :price_filter, '.price-filter'
  element :condition_filter, '.condition-filter'
  element :first_product, '.standard'
  element :pagination_container, '.pagination'
  element :next_page_link, '.nextPage'
  element :prev_page_link, '.prevPage'
  element :no_results_found, '.search_heading'
  element :color_swatch, '.color-swatch'
  element :back_to_top_button, '.backToTop'
  set_url "/search{?query*}"

    def GoToFirstProduct
      first_product.click
      ProductPage.new
    end

    def GoToResultsPage number
      pagination_container.click_link number
      SearchResultsPage.new
    end

    def GoToNextResultsPage
      next_page_link.click
      SearchResultsPage.new
    end

    def GoToPrevResultsPage
      prev_page_link.click
      SearchResultsPage.new
    end

    def SelectColor color
      color_filter.find("li[title=#{color}]").click
      self
    end

    def SelectCategory name
      category_filter.click_link name
      self
    end

    def SelectPrice values, checked=true
      price_filter.find(".price-#{values}").set(checked)
      self
    end

    def SelectCondition text, checked=true
      condition_filter.find(".condition-#{text}").set(checked)
      self
    end

    def GoBackToTop
      back_to_top_button.click
    end

  end
end
