require "../core/base_page"
require "../Google/website_page"
require "../Google/results_page"

include Pages

module Pages
  class HomePage < BasePage
    set_url "http://www.google.com"
    set_url_matcher /google.com\/?/

    element :search_field, "input[name='q']"
    element :search_button, ".gbqfb"
    elements :footer_links, "#footer a"

    def Search (query)
      Capybara::Node::Element
      wait_until_search_field_visible
      search_field.set query
      search_button.click
      ResultsPage.new query
    end
  end

end

