require 'spec_helper'

feature 'Search' do
  before(:all) do
    @rand = rand(1000).to_s
    @email = "testuser" + @rand + "@mailinator.com"
    @email2 =  "testuser" + @rand + @rand + "@mailinator.com"
    @password = 'Proto123!'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @createdemail = 'prototest@mailinator.com'
    @facebookemail = 'bkitchener@prototest.com'
  end

  before(:each) do
  end

  scenario 'Search' do
    @page = LoginPage.new
    @page.load
    @page = @page.LoginWithInfo @facebookemail, @password
    @page = @page.header.SearchFor "table"
    @page.GoToFirstProduct.AddToCart
  end
end