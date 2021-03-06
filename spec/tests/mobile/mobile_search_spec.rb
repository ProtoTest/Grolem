require 'spec_helper'
include Pages

feature 'Mobile Search' do
  before(:all) do
    @email = PROTOTEST_OKL_EMAIL
    @password = OKL_USER_PASSWORD
    @firstname = OKL_USER_FIRST_NAME
    @lastname = OKL_USER_LAST_NAME

    # register the user
    register_user(@firstname, @lastname, @password, @email)
  end

  before(:each) do
    @page = MobileHomePage.new
    @page.load
    @page = @page.GoToLoginPage.LoginWithInfo(@email, @password)
  end

scenario 'Search Regular Result Set' do
  @page = @page.header.SearchFor "rug"
  @page.should have_query_phrase :text=> "rug"
  @page.should have_pagination_container
end

scenario 'Search Thin Result Set' do
    @page = @page.header.SearchFor "quill pen"
    @page.should have_no_query_phrase
    @page.should have_no_pagination_container
    @page.should have_search_results_summary :text=>"quill pens"
  end

scenario 'Search null Result Set' do
  @page = @page.header.SearchFor "nintendo"
  @page.should have_no_query_phrase
  @page.should have_no_pagination_container
  @page.should have_no_search_results_summary
  @page.should have_no_results_found :text=>"nintendo"
end

scenario 'Pagination' do
  delay = 5

  @page = @page.header.SearchFor "table"
  @page.current_url.should_not include "&page="
  @page.GoToNextResultsPage
  sleep delay
  @page.current_url.should include "&page=1"
  @page.GoToPrevResultsPage
  sleep delay
  @page.current_url.should include "&page=0"

  num_pagination_links = @page.GetNumPaginationLinks
  @page.GoToResultsPage num_pagination_links.to_s
  sleep delay
  @page.current_url.should include "&page=#{num_pagination_links - 1}"
end

  scenario 'Filter' do
    delay = 5

    @page = @page.header.SearchFor 'table'

    @page.SelectColor 'White'
    sleep delay
    @page.current_url.should include 'color_hex=%23FFFFFF'
    @page.SelectColor 'White'
    sleep delay
    @page.current_url.should_not include 'color_hex=%23FFFFFF'

    @page.SelectCategory 'Furniture'
    sleep delay
    @page.current_url.should include 'level_1_category_ids=130000'
    @page.category_filter.should have_link 'Tables'

    @page.SelectPrice '100-250'
    sleep delay
    @page.current_url.should include 'price_ranges=100-250'
    @page.SelectPrice '100-250'
    sleep delay
    @page.current_url.should_not include 'price_ranges=100-250'

    @page.SelectCondition 'new'
    sleep delay
    @page.current_url.should include 'vmf=false'
    @page.SelectCondition 'new'
    sleep delay
    @page.current_url.should_not include 'vmf=false'

    @page.SelectCondition 'vintage'
    sleep delay
    @page.current_url.should include 'vmf=true'
    @page.SelectCondition 'vintage'
    sleep delay
    @page.current_url.should_not include 'vmf=true'
  end
end