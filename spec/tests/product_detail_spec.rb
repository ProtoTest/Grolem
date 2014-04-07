require 'spec_helper'
require_all 'pages'

include Pages


feature 'Product Details' do

# run this once before all of the scenarios
  before(:all) do
    @rand = rand(1000).to_s
    @email = "testuser" + @rand + "@mailinator.com"
    @email = "testuser680@mailinator.com"
    @email = "msiwiec@mailinator.com"
    @facebookemail = "bkitchener@prototest.com"
    @facebookpassword = "Proto123!"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @fullname = "#{@firstname} #{@lastname}"

    # register the user
    #register_user(@firstname, @lastname, @password, @email)

  end

  before(:each) do
    @page = login(@email, @password)
  end

  after(:each) do
    sleep 4
  end

  scenario 'Select Product Quantity and size' do
    @page = HomePage.new
    @page.load

    # Searching for rug products typically have size and quantity
    @page = @page.header.SearchFor("Bleeker Runner").
        GoToFirstProductNotSoldOutOnHold

    qty = 2
    size = nil
    # extract a size to use from the dropdown options
    @page.size_options.each do |opt|
      if not opt.text.include?("SOLD OUT") and not opt.text.include?("ON HOLD")
        size = opt.text
      end
    end

    raise "Failed to extract a size from the product size dropdown" if size.nil?

    @page.UpdateSizeQty(size, qty)
  end

  scenario 'Add Product to Cart' do
    @page = HomePage.new
    @page.load
    @page.header.SearchFor("lamp").GoToFirstProductNotSoldOutOnHold.AddToCart.VerifyItemAddedToCart
  end

  scenario 'Search is displayed in Product page header, UI is correct and Search is functional' do
    @page = HomePage.new
    @page.load
    @page = @page.header.SearchFor("lamp").
        GoToFirstProductNotSoldOutOnHold

    # The header contains the search elements, verify they are all there
    @page.header.search_container.should be_all_there

    @page.header.SearchFor("rug").
        GoToFirstProductNotSoldOutOnHold
  end

  scenario 'White Glove Tool Tip' do
    # Sofa's typically have the 'white glove' special shipping handling
    @page = HomePage.new
    @page.load
    @page = @page.header.SearchFor("Sofa").
        GoToFirstProductNotSoldOutOnHold
    @page.white_glove_section.should have_main_label
    @page.white_glove_section.should have_icon
    @page.white_glove_section.should have_description
  end

  scenario 'Social Sharing - Facebook' do
    share_msg = "This item is wicked cool Facebook!"

    @page = HomePage.new
    @page.load

    product_shared_str = @page.header.SearchFor("lamp").
        GoToFirstProductNotSoldOutOnHold.
        ShareViaFacebook(@facebookemail, @facebookpassword, share_msg)

    # Verify the item was actually posted to the facebook user's wall
    @page = FacebookLoginPage.new
    @page.load
    @page.LoginAs(@facebookemail, @facebookpassword).
        GoToNewsFeed.
        VerifyProductShared(product_shared_str)
  end

=begin
  scenario 'Social Sharing - Email' do

  end

  scenario 'Social Sharing - Pinterest' do

  end
=end
end

