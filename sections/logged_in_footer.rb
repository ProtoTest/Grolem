module Sections
  class LoggedInFooter<BaseSection
    element :about_us, 'a[href="/corporate/about_us"]'
    element :press, 'a[href="/press"]'
    element :careers, 'a[href="/careers"]'
    element :apps_ipad, 'a[href="/apps/ipad"]'
    element :apps_iphone, 'a[href="/apps/iphone"]'
    element :gift_card, 'a[href="/e-gift-card"]'
    element :vendor, 'a[href="/vendor-application"]'
    element :affiliates, 'a[href="/affiliates"]'
    element :sitemap, 'a[href="/corporate/sitemap"]'
    element :shipping, 'a[href="http://help.onekingslane.com/customer/portal/topics/32819-shipping-delivery/articles"]'
    element :returns, 'a[href="http://help.onekingslane.com/customer/portal/articles/72357-return-policy"]'
    element :help, 'a[href="http://help.onekingslane.com"]'
    element :copyright, 'div#oklCopyright'
  end

  def VerifyRenderedCorrectly
    about_us.present?
    press.present?
    careers.present?
    apps_ipad.present?
    apps_iphone.present?
    gift_card.present?
    vendor.present?
    affiliates.present?
    sitemap.present?
    shipping.present?
    returns.present?
    help.present?
    copyright.present?
  end
end