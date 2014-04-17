require 'capybara/node/element'
module Capybara
  module Node
    class Element
      include Capybara::DSL
      def present?
         page.has_selector? @query.selector.format, @query.locator
      end

      def set_checked(value)
        if (self.checked? and not value) or (not self.checked? and value)
          self.click
        end
      end

      def get_selected_option
        find('option[selected]').text
      end
    end
  end
end

def reset_capybara
  # reset the capybara session and configuration
  Capybara.reset_sessions!
  Capybara.reset!

  # Delete some cookies for the site that are hanging around
  page.driver.browser.manage.delete_cookie('ewokAuth')
  page.driver.browser.manage.delete_cookie('ewokAuthGuestPass')
  page.driver.browser.manage.delete_cookie('keepLogin')
  page.driver.browser.manage.delete_cookie('is_member')

  # Ensure the browser is maximized to maximize visibility of element
  page.driver.browser.manage.window.maximize
end
