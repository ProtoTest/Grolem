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
    visit RSpec.configuration.default_url
  end

  scenario 'LogIn' do
    @page.
        Login.
        LoginWithInfo(@email,@password).
        ClosePanel
  end

end

