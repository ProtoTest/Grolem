module Sections
  include Pages
  class MobileFooter < BaseSection
    element :upcoming_sales_link, :text => 'Upcoming Sales'
    element :join_now_link, :text => 'Join Now'
    element :log_in_link, :text => 'Log In'
    element :help_link, :text => 'help'
    element :non_mobile_link, :text => 'non-mobile version'
    element :terms_link, :text => 'terms'
    element :privacy_link, 'privacy'
    element :my_account_link, :text=>'My Account'
    element :log_out_link, :text=>"Log Out"
  end

  end