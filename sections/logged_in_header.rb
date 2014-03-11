require_all 'pages'

module Sections
  include Pages
  class LoggedInHeader < SitePrism::Section
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
    element :log_out_link, 'a', :text=>"LOG OUT"

    element :shopping_cart_link, '#micro-cart-container'

    def ClickAllSales
      all_sales_link.click
      HomePage.new
    end

    def ClickLogo
      logo_link.click
      HomePage.new
    end

    def ClickVintage
      vintage_link.click
      TodaysArrivalsPage.new
    end

    def ClickUpcomingSales
      upcoming_sales.link.click
      CalendarPage.new
    end

    def ClickStyleBlog
      style_blog.click
      LiveLoveHomePage.new
    end

    def LogOut
      welcome_user_dropdown.click
      log_out_link.click
      LoginPage.new
    end

    def SearchFor text
      search_fieid.set text
      search_button.click
      LoginPage.new
    end
  end
end
