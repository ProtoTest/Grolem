require 'capybara/node/element'
module Capybara
  module Node
    class Element
      include Capybara::DSL
      def present?
         page.has_selector? @query.locator
      end
    end
  end
end
