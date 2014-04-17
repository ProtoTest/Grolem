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
    @email = "prototest@mailinator.com"
    @facebookemail = "bkitchener@prototest.com"
  end

  scenario 'Join as new User' do
    @page.
        EnterEmail(@newemail).
        EnterInfo(@firstname,@lastname,@password).
        ClosePanel
  end

  scenario 'Forgot Password' do
    @page = LoginPage.new
    @page.load
    @page.ForgotPassword @newemail
    @page = MailinatorPage.new
    @page.load(username: @rand_username)
    @page.ClickMailWithText 'Please Reset Your One Kings Lane Password'
    @page.ClickBodyText 'Click here to reset your password'
    @page = ResetPasswordPage.new

    @page.ResetPasswordTo(@newpassword).LogOut
  end

end

