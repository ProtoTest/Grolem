module Sections
  include Pages
  class LoggedInHeader < BaseSection
    attr_reader :mini_cart

    element :invite_friends_link,".invite-friends"
    element :all_sales_link,:text,"All Sales"
    element :vintage_link, :text,"Vintage"
    element :upcoming_sales_link, 'a',:text => "Upcoming Sales"
    element :style_blog, 'a',:text=> "Style Blog"

    element :logo_link,'a',:text=>"One Kings Lane"
    element :search_field,'.search-field'
    element :search_button, '.search-icon'

    element :welcome_user_dropdown, :xpath, "//span[contains(text(),'Welcome')]"
    element :my_account_link,'a', :text=>"My Account"
    element :log_out_link, 'a', :xpath, "//a[@href='/logout']"

    element :shopping_cart_link, :xpath, "//a[@href='/cart']"

    section :mini_cart, Sections::ShoppingCartModal, '#micro-cart' # typically displays after adding an item to the cart

    def GoToAllSales
      all_sales_link.click
      HomePage.new
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
      log_out_link.click
      LoginPage.new
    end

    def SearchFor text
      search_field.set text
      search_button.click
      SearchResultsPage.new
    end

    def GoToCart
      #wait_until_shopping_cart_link_visible
      shopping_cart_link.click
      ShoppingCartPage.new
    end
  end
end
