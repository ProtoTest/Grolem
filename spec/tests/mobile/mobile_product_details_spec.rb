require 'spec_helper'
require_all 'pages'

include Pages


feature 'Product Details' do

# run this once before all of the scenarios
  before(:all) do
    @email = "bkitchener@prototest.com"
    @share_email = "prototest@mailinator.com"
    @facebookemail = "bkitchener@prototest.com"
    @password = 'Proto123!'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @fullname = "#{@firstname} #{@lastname}"
  end

  before(:each) do
    @page = MobileHomePage.new
    @page.load
    @page = MobileLoginPage.new
    @page.load
    @page.LoginWithInfo(@facebookemail,@password)
    sleep 2
  end

  scenario 'Select Product Quantity and size' do
    @page = MobileSearchResultsPage.new
    visit("/search?q=rugs")
    # Searching for rug products typically have size and quantity
    @page.GoToFirstProduct

    qty = 2
    size = 1
    @page = MobileProductPage.new
    @page.SelectQuantity(qty)
    @page.SelectSizeByIndex(size)

  end

  #scenario 'Add Product to Cart' do
  #  @page = MobileSearchResultsPage.new
  #  visit("/search?q=rugs")
  #  @page.GoToFirstProduct(:available).AddToCart.VerifyItemAddedToCart
  #end
  #
  #
  #scenario 'White Glove Tool Tip' do
  #  # Sofa's typically have the 'white glove' special shipping handling
  #  @page = MobileSearchResultsPage.new
  #  visit("/search?q=rugs")
  #      @page.GoToFirstProduct(:available)
  #  @page.white_glove_section.should have_main_label
  #  @page.white_glove_section.should have_icon
  #  @page.white_glove_section.should have_description
  #end
  #
  #scenario 'Social Sharing - Facebook' do
  #  share_msg = "This item is wicked cool Facebook!"
  #  @page = MobileSearchResultsPage.new
  #  visit("/search?q=lamp")
  #  product_shared_str = @page.
  #      GoToFirstProduct(:available).
  #      ShareViaFacebook(@facebookemail, @facebookpassword, share_msg)
  #
  #  # Verify the item was actually posted to the facebook user's wall
  #  @page = FacebookLoginPage.new
  #  @page.load
  #  @page.LoginAs(@facebookemail, @facebookpassword).
  #      GoToNewsFeed.
  #      VerifyProductShared(product_shared_str)
  #end
  #
  #scenario 'Social Sharing - Pinterest' do
  #  @page = MobileSearchResultsPage.new
  #  visit("/search?q=rugs")
  #
  #  product_shared_str = @page.
  #      GoToFirstProduct(:available).
  #      ShareViaPinterest(@facebookemail, @facebookpassword)
  #
  #  # get into pinterest account and verify product was pinned to the okl board
  #  @page = PinterestPage.new
  #  @page.load
  #
  #  @page.should have_text product_shared_str
  #
  #end

end

