module Sections
  include Pages
  class SearchSection < BaseSection
    element :search_field, '.search-field'
    element :search_button, :xpath, ".//button[contains(@class,'search-icon')]"
    element :search_label, :xpath, ".//form[contains(@class,'search-form')]/fieldset/label[contains(text(),'Search by item or category')]"

    def VerifyPresent
      search_field.present?
      search_button.present?
      search_label.present?
    end
  end

  class LoggedInHeader < BaseSection
    attr_reader :mini_cart, :search_container

    element :invite_friends_link, '.invite-friends'
    element :all_sales_link, '#all-sales'
    element :vintage_link, 'a[data-linkname="header_vmf"]'
    element :upcoming_sales_link, 'a[data-linkname="header_calendar"]'
    element :style_blog, 'a[data-linkname="header_llh"]'
    elements :all_sales_events, '.latest-sales a'
    element :logo_link, 'a[data-linkname="header_logo"]'
    element :welcome_user_dropdown, 'li.welcome'
    element :my_account_link, 'a[href="/my_account"]'
    element :log_out_link, 'a', :xpath, "//a[@href='/logout']"

    element :shopping_cart_link, 'a[href="/cart"]'
    section :search_container, SearchSection, '.search-container'
    section :mini_cart, Sections::ShoppingCartModal, '#micro-cart' # typically displays after adding an item to the cart

    element :referral_credit_link, '.credits'

    def GoToAllSales
      all_sales_link.click
      HomePage.new
    end

    # Go to a current sale by its 0-indexed position in the all sales header dropdown.
    def GoToCurrentSale(position)
      # Open the sales drop down: sales aren't loaded until the drop down is visible.
      wait_for_all_sales_link
      all_sales_link.hover
      wait_for_all_sales_events
      $logger.Log "Navigating to sale #{all_sales_events[position].text}"
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
      #welcome_user_dropdown.click
      visit "/logout"

      LoginPage.new
    end

    def SearchFor text
      search_container.search_field.set text
      search_container.search_button.click

      SearchResultsPage.new
    end

    def GoToCart
      page = ShoppingCartPage.new
      page.load

      page
    end

    # for customers who were invited
    def VerifyReferralAndCredits
      referral_link_txt = "MY CREDITS $15"

      if not referral_credit_link.text.eql?(referral_link_txt)
        raise "Failed to verify the referral credit link in the header's text is #{referral_link_txt}"
      end

      referral_credit_link.click

      MyAccountCreditOffersPage.new
    end

    def WaitForMicroCartToDisplay
      wait_until_mini_cart_visible
    end

    def VerifyRenderedCorrectly
      welcome_user_dropdown.present?
      link_results = [
          verify_link(:invite_friends_link, 'Get $15 every time a friend you invite makes a first purchase'),
          verify_link(:all_sales_link, 'All Sales'),
          verify_link(:vintage_link, 'Sort by'),
          verify_link(:upcoming_sales_link, 'Calendar'),
          verify_link(:style_blog, 'DAILY INSPIRATION
from
ONE KINGS LANE'),
          verify_link(:logo_link, 'Ending Soon'),
          verify_link(:my_account_link, 'Personal Information', lambda {
            welcome_user_dropdown.hover
            wait_for_my_account_link }),
          verify_link(:shopping_cart_link, 'Shopping Cart'),
          verify_link(:log_out_link, 'LOG', lambda {
            welcome_user_dropdown.hover
            wait_for_my_account_link })]
      failed_elements = link_results.map do |element, text, correct|
        next if correct
        "Link \"#{element}\" lead to a page which did not contain the expected text: \"#{text}\""
      end

      # the link_results.map call will always have at least one element in it, and it should be nil
      if failed_elements.length > 0 and not failed_elements[0].nil?
        fail(failed_elements.join('\n'))
      end
    end

    private
    def verify_link(element, text, pre_fn=nil)
      if not pre_fn.nil?
        pre_fn.call()
      end
      self.send(element).click
      correct_page = page.has_text? text
      page.go_back
      [element, text, correct_page]

    end
  end
end
