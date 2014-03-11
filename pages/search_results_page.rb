require 'site_prism'

module Pages
  class SearchResultsPage < SitePrism::Page
    set_url '/search?q='
  end
end
