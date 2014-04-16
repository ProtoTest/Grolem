require 'spec_helper'
require_all 'pages'

include Pages


feature 'Vintage Market Find (VMF)' do

# run this once before all of the scenarios
  before(:all) do
    @rand = rand(1000).to_s
    @email = "testuser" + @rand + "@mailinator.com"
    @email = "msiwiec@mailinator.com"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @fullname = "#{@firstname} #{@lastname}"

    # register the user
    register_user(@firstname, @lastname, @password, @email)

  end

  before(:each) do
    @page = MobileHomePage.new
    @page.load
    @page = @page.GoToLoginPage.LoginWithInfo(@email, @password)
  end

  after(:each) do

  end

  scenario 'Header and page renders correctly' do
    # The desktop header and page is rendered for VMF
  end

  scenario 'Badges: Inventory - Sold Out tag visible' do
    @page = @page.header.SearchFor("Vintage").
        GoToFirstProduct(:sold_out)

    @page.should have_text("SOLD OUT")
  end

  scenario 'Badges: Vintage tag is visible for vintage items' do
    @page = @page.header.SearchFor("Vintage").
        GoToFirstProduct(:available_vintage)
  end

  scenario 'Today\'s Arrival Carousel Works' do
    @page = TodaysArrivalsPage.new
    @page.load

    @page.VerifyCarouselPosition(:first).
        MoveCarouselBack.
        VerifyCarouselPosition(:first).
        MoveCarouselForward.
        VerifyCarouselPosition(:second).
        MoveCarouselForward.
        VerifyCarouselPosition(:third).
        MoveCarouselForward.
        VerifyCarouselPosition(:third)
  end

  scenario 'Shop by Vendor link works on product detail page (PDP)' do
    # There is no 'Shop by Vendor' link on the mobile PDP
  end

end

