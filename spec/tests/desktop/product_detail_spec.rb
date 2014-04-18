require 'spec_helper'
require_all 'pages'

include Pages


feature 'Product Details' do

# run this once before all of the scenarios
  before(:all) do
    @share_email = "msiwiec@mailinator.com"
    @email = PROTOTEST_OKL_EMAIL
    @facebookemail = FACEBOOK_EMAIL
    @facebookpassword = FACEBOOK_PASSWORD
    @password = OKL_USER_PASSWORD
    @firstname = OKL_USER_FIRST_NAME
    @lastname = OKL_USER_LAST_NAME
    @fullname = "#{@firstname} #{@lastname}"

    # register the user
    register_user(@firstname, @lastname, @password, @email)

  end

  before(:each) do
    # In order to be able to send emails from the site, a throwaway email address
    # must NOT be used.
    @page = login(@email, @password)
  end

  after(:each) do

  end

  scenario 'Select Product Quantity and size' do
    @page = HomePage.new
    @page.load

    # Searching for rug products typically have size and quantity
    @page = @page.header.SearchFor("Red Rug").
        GoToFirstProduct

    qty = 2
    size = nil

    raise "Product found does not have a size option" if @page.has_no_size_options?

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
    @page.header.SearchFor("lamp").GoToFirstProduct(:available).AddToCart.VerifyItemAddedToCart
  end

  scenario 'Search is displayed in Product page header, UI is correct and Search is functional' do
    @page = HomePage.new
    @page.load
    @page = @page.header.SearchFor("lamp").
        GoToFirstProduct(:available)

    # The header contains the search elements, verify they are all there
    @page.header.search_container.should be_all_there

    @page.header.SearchFor("rug").
        GoToFirstProduct(:available)
  end

  scenario 'White Glove Tool Tip' do
    # Sofa's typically have the 'white glove' special shipping handling
    @page = HomePage.new
    @page.load
    @page = @page.header.SearchFor("Sofa").
        GoToFirstProduct(:available)
    @page.white_glove_section.should have_main_label
    @page.white_glove_section.should have_icon
    @page.white_glove_section.should have_description
  end

  scenario 'Social Sharing - Facebook' do
    share_msg = "This item is wicked cool Facebook!"

    @page = HomePage.new
    @page.load

    product_shared_str = @page.header.SearchFor("lamp").
        GoToFirstProduct(:available).
        ShareViaFacebook(@facebookemail, @facebookpassword, share_msg)

    # Verify the item was actually posted to the facebook user's wall
    @page = FacebookLoginPage.new
    @page.load
    @page.Login(@facebookemail, @facebookpassword).
        GoToNewsFeed.
        VerifyProductShared(product_shared_str)
  end

  scenario 'Social Sharing - Email' do
    message = "I am the walrus"

    @page = HomePage.new
    @page.load

    product_shared_str = @page.header.SearchFor("lamp").
        GoToFirstProduct(:available).ShareViaEmail(@share_email, message)

    # logout
    @page = HomePage.new
    @page.load
    @page.header.LogOut

    # visit the mailinator page, with just the username, not the domain
    visit "http://mailinator.com/inbox.jsp?to=#{@share_email.gsub(/@mailinator.com/, '')}"

    @page = MailinatorPage.new.ClickMailWithText 'thought you would love'
    within_frame(find('#mailshowdivbody>iframe')) do
      @page.should have_text "Personal message: #{message}"
      @page.should have_text product_shared_str
    end
  end

  scenario 'Social Sharing - Pinterest' do
    @page = HomePage.new
    @page.load

    product_shared_str = @page.header.SearchFor("lamp").
        GoToFirstProduct(:available).
        ShareViaPinterest(@facebookemail, @facebookpassword)

    # get into pinterest account and verify product was pinned to the okl board
    @page = PinterestPage.new
    @page.load

    @page.should have_text product_shared_str

  end

end

