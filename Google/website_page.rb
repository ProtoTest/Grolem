require "../core/base_page"

module Pages
  class WebsitePage < BasePage
    def GoBack
      page.go_back
      ResultsPage.new ""
    end
  end

end

