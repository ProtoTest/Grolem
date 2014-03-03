require '../spec_helper'
require '../pages/home_page'

describe 'home page' do
  it 'welcomes the user' do
    @page = HomePage.new
    @page.load
    @page.
        Search("prototest").
        ClickFirstResult.
        GoBack.
        ClickFirstResult.
        GoBack.
        GoBack.
        Search("okl").
        ClickFirstResult.
        GoBack.
        GoBack
  end
end