module Core
  class VerificationError
    include Capybara::DSL
    attr_accessor :message, :screenshot
    def initialize message, screenshot
      @message = message
      @screenshot =
    end
  end
end
