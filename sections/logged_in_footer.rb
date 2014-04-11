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
    verify_links([[about_us, 'One King\'s lane is a website'],
        [press, 'Recent Press'],
        [careers, "One King's Lane has an awesome work environment. Join us."],
        [apps_ipad, 'one kings lane + ipad'],
        [apps_iphone, 'One Kings Lane iPhone App'],
        [gift_card, 'E-Gift Card'],
        [vendor, 'Become a Vendor on One Kings Lane'],
        [affiliates, 'Affiliate Program'],
        [sitemap, 'Everything out site has to offer'],
        [shipping, 'Shipping & Delivery'],
        [returns, 'Return policy'],
        [help, 'Frequently Asked Questions']])
    copyright.present?
  end

  private
  def verify_links(verifications)
    failed_elements = verifications.map do |element, verification_text|
      next_page = element.click
      correct_page = page.has_text? verification_text
      page.go_back
      next if correct_page
      "Footer link \"#{element.text}\" lead to a page which did not contain the expected text: \"#{verification_text}\""
    end
    if failed_elements.length != 0
      fail(failed_elements.join('\n'))
    end
  end

end