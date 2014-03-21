require 'capybara/node/element'
module Capybara
  module Node
    class Element
      include Capybara::DSL
      def present?
         page.has_selector? @query.locator
      end

      def wait_until_visible time
        until (visible?)
          sleep(1)
        end
      end
    end
  end

  class Element
    include Capybara::DSL
    def present?
      page.has_selector? @query.locator
    end

    def wait_until_visible time
      until (visible?)
        puts "waiting_until"
      end
      def set_checked(value)
        if (self.checked? and not value) or (not self.checked? and value)
          self.click
        end
      end
    end
  end
end
