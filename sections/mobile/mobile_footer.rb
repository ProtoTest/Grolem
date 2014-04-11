module Sections
    class MobileFooter < BaseSection
      element :upcoming_sales_link, 'a', :text => 'Upcoming Sales'
      element :join_now_link, 'a', :text => 'Join Now'
      element :log_in_link, 'a', :text => 'Log In'
      element :help_link, 'a', :text => 'help'
      element :non_mobile_link, 'a', :text => 'non-mobile version'
      element :terms_link,'a',  :text => 'terms'
      element :privacy_link, 'a', :text=> 'privacy'
      element :my_account_link, 'a', :text=>'My Account'
      element :log_out_link, 'a', :text=>'LOG OUT'
    end

  def VerifyLoggedIn
    self.should have_log_out_link
    self
  end

  def LogOut
    log_out_link.click
    MobileHomePage.new
  end
  end