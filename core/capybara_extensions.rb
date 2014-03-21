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
    end
  end
end



