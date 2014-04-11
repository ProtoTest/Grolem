require 'spec_helper'
include Pages

feature 'Search' do
  before(:all) do
    @rand = rand(1000).to_s
    @newemail = "testuser" + @rand + "@mailinator.com"
    @newemail2 =  "testuser" + @rand + @rand + "@mailinator.com"
    @password = 'Proto123!'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @newemail = 'prototest@mailinator.com'
    @facebookemail = 'bkitchener@prototest.com'
  end

  before(:each) do
  end

scenario 'Search Regular Result Set' do
  @page = LoginPage.new
  @page.load
  @page = @page.LoginWithInfo @facebookemail, @password
  @page = @page.header.SearchFor "rug"
  @page.should have_query_phrase :text=> "rug"
  @page.should have_pagination_container
end

scenario 'Search Thin Result Set' do
    @page = LoginPage.new
    @page.load
    @page = @page.LoginWithInfo @facebookemail, @password
    @page = @page.header.SearchFor "quill pen"
    @page.should have_no_query_phrase
    @page.should have_no_pagination_container
    @page.should have_search_results_summary :text=>"quill pens"
  end

scenario 'Search null Result Set' do
  @page = LoginPage.new
  @page.load
  @page = @page.LoginWithInfo @facebookemail, @password
  @page = @page.header.SearchFor "nintendo"
  @page.should have_no_query_phrase
  @page.should have_no_pagination_container
  @page.should have_no_search_results_summary
  @page.should have_no_results_found :text=>"nintendo"
end

scenario 'Pagination' do
  @page = LoginPage.new
  @page.load
  @page = @page.LoginWithInfo @facebookemail, @password
  @page = @page.header.SearchFor "table"
  @page.current_url.should_not include "&page="
  @page.GoToNextResultsPage
  sleep 3
  @page.current_url.should include "&page=1"
  @page.GoToPrevResultsPage
  sleep 3
  @page.current_url.should include "&page=0"
  @page.GoToResultsPage "10"
  sleep 3
  @page.current_url.should include "&page=9"
end

  scenario 'Filter' do
    @page = LoginPage.new
    @page.load
    @page = @page.LoginWithInfo @facebookemail, @password
    @page = @page.header.SearchFor 'table'

    @page.SelectColor 'White'
    sleep 2
    @page.current_url.should include 'color_hex=%23FFFFFF'
    @page.SelectColor 'White'
    sleep 2
    @page.current_url.should_not include 'color_hex=%23FFFFFF'

    @page.SelectCategory 'Furniture'
    sleep 2
    @page.current_url.should include 'level_1_category_ids=130000'
    @page.category_filter.should have_link 'Tables'

    @page.SelectPrice '100-250'
    sleep 2
    @page.current_url.should include 'price_ranges=100-250'
    @page.SelectPrice '100-250'
    sleep 2
    @page.current_url.should_not include 'price_ranges=100-250'

    @page.SelectCondition 'new'
    sleep 2
    @page.current_url.should include 'vmf=false'
    @page.SelectCondition 'new'
    sleep 2
    @page.current_url.should_not include 'vmf=false'

    @page.SelectCondition 'vintage'
    sleep 2
    @page.current_url.should include 'vmf=true'
    @page.SelectCondition 'vintage'
    sleep 2
    @page.current_url.should_not include 'vmf=true'
  end
end