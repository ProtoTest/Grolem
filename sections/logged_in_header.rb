module Sections
  include Pages
  class LoggedInHeader < BaseSection
    attr_reader :mini_cart

    element :invite_friends_link,".invite-friends"
    element :all_sales_link,"#all-sales"
    element :vintage_link, :text,"Vintage"
    element :upcoming_sales_link, 'a',:text => "Upcoming Sales"
    element :style_blog, 'a',:text=> "Style Blog"
    elements :all_sales_events, ".latest-sales a"

    element :logo_link,'a',:text=>"One Kings Lane"
    element :search_field,'.search-field'
    element :search_button, :xpath, "//button[contains(@class,'search-icon')]"

    element :welcome_user_dropdown, :xpath, "//span[contains(text(),'Welcome')]"
    element :my_account_link,'a', :text=>"My Account"
    element :log_out_link, 'a', :xpath, "//a[@href='/logout']"

    elements :shopping_cart_link, :xpath, "//a[@href='/cart']"

    section :mini_cart, Sections::ShoppingCartModal, '#micro-cart' # typically displays after adding an item to the cart

    element :referral_credit_link, '.credits', :text => "MY CREDITS $15"

    def GoToAllSales
      all_sales_link.click
      HomePage.new
    end

    # Go to a current sale by its 0-indexed position in the all sales header dropdown.
    def GoToCurrentSale(position)
      # Open the sales drop down: sales aren't loaded until the drop down is visible.
      all_sales_link.hover
      sleep(1)
      all_sales_events[position].click
      SalesEvent.new
    end

    def GoToLogo
      logo_link.click
      HomePage.new
    end

    def GoToVintage
      vintage_link.click
      TodaysArrivalsPage.new
    end

    def GoToUpcoming
      upcoming_sales.link.click
      CalendarPage.new
    end

    def GoToStyleBlog
      style_blog.click
      LiveLoveHomePage.new
    end

    def LogOut
      welcome_user_dropdown.click
      visit "/logout"

      LoginPage.new.wait_for_elements
    end

    def SearchFor text
      search_field.set text
      search_button.click
      SearchResultsPage.new.wait_for_elements
    end

    def GoToCart
      page = ShoppingCartPage.new
      page.load

      page
    end

    # for customers who were invited
    def VerifyReferralAndCredits
      referral_credit_link.click
      MyAccountCreditOffersPage.new.wait_for_elements
    end

    def WaitForMicroCartToDisplay
      wait_until_mini_cart_visible
    end
  end
end
