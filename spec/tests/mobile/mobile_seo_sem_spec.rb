require 'spec_helper'
require 'login_page'
require 'mailinator_page'
include Pages


feature 'SEO and SEM' do
    before(:all) do
      @rand = rand(1000).to_s
      @rand_username = "testuser" + @rand
      @rand_username2 = "testuser" + @rand + @rand
      @newemail =  @rand_username + "@mailinator.com"
      @newemail2 =  @rand_username2 + "@mailinator.com"
      @email = "prototest@mailinator.com"
      @facebookemail = "bkitchener@prototest.com"
      @password = "Proto123!"
      @firstname = "TestUser"
      @lastname = "ProtoTest"

      # register the user
      register_user(@firstname, @lastname, @password, @newemail)
    end

    before(:each) do
      @page = MobileHomePage.new
      @page.load
      @page = @page.GoToLoginPage.LoginWithInfo(@newemail, @password)
    end

    scenario 'Discover' do
      @page = DiscoverPage.new
      @page.load
      @page.should have_title_label
      @page.should have_description_label
      @page.should have_sort_by_best_sellers_link
      @page.should have_sort_by_price_link
      @page.should have_products
      @page.should have_event_container
      @page.should have_see_all_sales_link
end

  scenario 'Browse' do
    @page = BrowsePage.new
    visit('/browse/floor-coverings/4533')
    @page.wait_for_elements
  end
end

