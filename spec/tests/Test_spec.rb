require 'spec_helper'
require 'signup_modal'
include Pages

feature 'UserLogin' do
  before(:all) do
    @rand = rand(1000).to_s
    @email = "testuser" + @rand + "@mailinator.com"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @page = SignupModal.new
    @page.load
  end

  scenario 'Register' do
    @page.
        EnterEmail(@email).
        EnterInfo(@firstname,@lastname,@password)
  end

end

