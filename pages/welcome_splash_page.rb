require "../core/base_page"
require "../pages/register_modal"
require "../pages/login_page"
require "../core/element"

module Pages
  class WelcomeSplashPage < BasePage
    include Core
    def initialize
      @@close_button = WebElement.new '#x_out'
      @@shop_todays_sales = WebElement.new "#shop_todays"
      @@welcome_panel = WebElement.new "#successContents"
      @@change_email_pref_link = WebElement.new "#email_pref"
      @@invite_friends_button = WebElement.new "#invite_circle"
    end
    def InviteFriends
      @@invite_friends_button.click
    end

    def ClosePanel
      @@close_button.click
    end

    def ShopTodaysSales
      @@shop_todays_sales.click
    end
  end
end
