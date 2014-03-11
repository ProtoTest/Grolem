require 'site_prism'
require 'register_modal'
require 'login_modal'
require 'home_page'

module Pages
  class WelcomeSplashPage < SitePrism::Page

    attr_reader :close_button,:shop_todays_sales,:welcome_panel,:change_email_pref_link,:invite_friends_button
      element :close_button, '#x_out'
      element :shop_todays_sales, "#shop_todays"
      element :welcome_panel, "#successContents"
      element :change_email_pref_link, "#email_pref"
      element :invite_friends_button, "#invite_circle"
    def InviteFriends
      invite_friends_button.click
    end

    def ClosePanel
      close_button.click
      HomePage.new
    end

    def ShopTodaysSales
      shop_todays_sales.click
      HomePage.new
    end
  end
end
