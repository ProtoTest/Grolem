require 'spec_helper'
require 'login_page'
require 'mailinator_page'
include Pages


feature 'User Login' do
  before(:all) do
    @rand = rand(1000).to_s
    @rand_username = "testuser" + @rand
    @newemail =  @rand_username + "@mailinator.com"
    @newemail2 =  @rand_username + @rand + "@mailinator.com"
    @password = "Proto123!"
    @firstname = "TestUser"
    @lastname = "ProtoTest"
    @newemail = "prototest@mailinator.com"
    @facebookemail = "bkitchener@prototest.com"
  end
  scenario 'Join as new User' do
    @page = SignupModal.new
    @page.load
    @page.
        EnterEmail(@newemail).
        EnterInfo(@firstname,@lastname,@password).ClosePanel
  end
end

