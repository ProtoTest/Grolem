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
    link_results = [verify_link(about_us, 'One King\'s lane is a website'),
                    verify_link(press, 'Recent Press'),
                    verify_link(careers, "One King's Lane has an awesome work environment. Join us."),
                    verify_link(apps_ipad, 'one kings lane + ipad'),
                    verify_link(apps_iphone, 'One Kings Lane iPhone App'),
                    verify_link(gift_card, 'E-Gift Card'),
                    verify_link(vendor, 'Become a Vendor on One Kings Lane'),
                    verify_link(affiliates, 'Affiliate Program'),
                    verify_link(sitemap, 'Everything out site has to offer'),
                    verify_link(shipping, 'Shipping & Delivery'),
                    verify_link(returns, 'Return policy'),
                    verify_link(help, 'Frequently Asked Questions')]
    failed_elements = link_results.map do |element, text, correct|
      next if correct
      "Link \"#{element.text}\" lead to a page which did not contain the expected text: \"#{text}\"\n"
    end
    copyright.present?
    if failed_elements.length > 0
      fail(failed_elements.join())
    end
  end

  private
  def verify_link(element, text, pre_fn=nil)
    if pre_fn
      pre_fn()
    end
    element.click
    correct_page = page.has_text? text
    page.go_back
    [element, text, correct_page]

  end

end