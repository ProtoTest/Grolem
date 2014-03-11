module Pages
  class MailinatorPage <SitePrism::Page
    include Capybara::DSL
    set_url 'http://mailinator.com/inbox.jsp?to=prototest'

    def ClickText text
      link = :xpath, "//*[contains(text(),'" + text + "')]"
      page.wait_for_element link
      link.click
      self
    end

  end
end
