require "site_prism"
require "../pages/Result"

class ResultsPage < SitePrism::Page
set_url ""
set_url_matcher /google.com\/?/

element :search_field, "input[name='q']"
element :search_button, ".gbqfb"
elements :results_links, "#center_colz a"

  def initialize query
    @query=query

  end

  def ValidateSearchResults
    wait_for_search_field
    wait_for_search_button
    wait_for_footer_links
  end

def ClickFirstResult
  wait_for_results_links
  results_links[0].click
  ResultLink.new
end

  def ClickResult
    wait_for_results_links
    first(:link,@query).click
    ResultLink.new
  end

  def GoBack
    page.go_back
    HomePage.new
  end
end

