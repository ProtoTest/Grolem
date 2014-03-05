require "../core/base_page"
include Pages
module Pages
  class WelcomeSplashPage  < BasePage
    set_url ""
    set_url_matcher /onekingslane.com\/?/
    element :close_button,"#x_out"
    element :shop_todays_sales, "#shop_todays"
    element :welcome_panel, "#successContents"
    element :change_email_pref_link, "#email_pref"
    element :invite_friends_button, "#invite_circle"

    def InviteFriends
      invite_friends_button.click
    end

    def ClosePanel
      close_button.click
    end

    def ShopTodaysSales
      shop_todays_sales.click
    end
  end
end
