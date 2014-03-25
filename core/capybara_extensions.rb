require 'capybara/node/element'
module Capybara
  module Node
    class Element
      include Capybara::DSL
      def present?
         page.has_selector? @query.locator
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
