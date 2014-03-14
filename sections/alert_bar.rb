module Sections
  class AlertBar < SitePrism::Section
    element :alert_bar_close_button ,".dismiss"
    element :alert_bar_message,'.highlight'
  end
end
