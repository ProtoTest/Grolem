require "capybara"

class WebElement < Capybara::Node::Element
  include Capybara::DSL
  attr_accessor :find_args

  def initialize(*find_args)
    puts 'Init element'
    @find_args=*find_args
  end
  def element
    puts 'Finding element'
    find(find_args)
  end
  def checked?
    element.checked?
  end
  def disabled?
    element.disabled?
  end
  def double_click
    element.double_click
  end
  def click
    puts 'Clicking element'
    element.click
  end
  def set text
    element.set text
  end
end