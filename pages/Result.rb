require "site_prism"

class ResultLink < SitePrism::Page
  set_url ""

  def GoBack
    page.go_back
    ResultsPage.new ""
  end
end

