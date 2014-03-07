require 'site_prism'
require 'register_modal'
require 'login_page'
require 'element'

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
    end

    def ShopTodaysSales
      shop_todays_sales.click
    end
  end
end
