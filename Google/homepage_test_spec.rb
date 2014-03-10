require "../core/base_page"
require "../Google/home_page"
include Pages

describe 'home page' do
  it 'welcomes the user', js: true do
    RSpec.configure do |config|
      $logger.Log config.default_browser
    end
    @page = HomePage.new
        @page.load
        @page.
        Search("prototest").
        ClickFirstResult.
        GoBack
        ClickFirstResult.
        GoBack.
        GoBack.
        Search("okl").
        ClickFirstResult.
        GoBack.
        GoBack
  end

end