module Pages
  class FacebookMainPage < BasePage
    set_url "http://www.facebook.com"

    element :news_feed_link, :xpath, "//div[contains(text(),'News Feed')]"
    element :user_navigation_dropdown, '#userNavigationLabel'
    element :logout_link, '.uiLinkButtonInput'

    def VerifyProductShared(product_str)
      xpath_str = "//a[contains(text(),'%s')]" % product_str
      find(:xpath, xpath_str)

      self
    end

    def GoToNewsFeed
      news_feed_link.click

      self
    end

    def LogOut
      user_navigation_dropdown.click
      logout_link
    end
  end
end