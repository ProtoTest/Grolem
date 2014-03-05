require "capybara"

module Core
  class WebElement
    include Capybara::DSL
    attr_accessor :find_args

    def initialize(*find_args)
      puts 'Init element ' + find_args.to_s
      @find_args=*find_args
    end
    def element
      puts 'Finding element'
      page.find(*@find_args)
    end
    def checked?
      element.checked?
    end
    def click
      puts 'Clicking element ' + @find_args.to_s
      element.click
    end
    def disabled?
      element.disabled?
    end
    def double_click
      element.double_click
    end
    def drag_to node
      element.drag_to node
    end
    def hover
      element.hover
    end
    def path
      element.path
    end
    def reload
      element.reload
    end
    def right_click
      element.right_click
    end
    def select_option
      element_select_option
    end
    def selected?
      element.selected?
    end
    def set text
      element.set text
    end
    def tag_name
      element.tag_name
    end
    def text(type=nil)
      element.text type
    end
    def trigger event
      element.trigger event
    end
    def unselect_option
      element.unselect_option
    end
    def value
      element.value
    end
    def visible?
      element.visible?
    end
  end
end
