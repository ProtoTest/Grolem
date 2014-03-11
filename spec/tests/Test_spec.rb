require 'spec_helper'
require 'login_page'
require 'mailinator_page'
include Pages


feature 'User Login' do
  before(:all) do
    @rand = rand(1000).to_s
    @email = "testuser" + @rand + "@mailinator.com"
    @email2 =  "testuser" + @rand + @rand + "@mailinator.com"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @createdemail = 'prototest@mailinator.com'
    @facebookemail = 'bkitchener@prototest.com'
    @facebookpassword = 'Proto123!'
  end

  scenario 'Forgot Password' do
    #@page = LoginPage.new
    #@page.load
    #@page.ForgotPassword @createdemail

    @page = MailinatorPage.new
    @page.load
    @page.ClickText 'One Kings Lane'
    @page.ClickText 'Click here to reset your password'
    @page = ResetPasswordPage.new
    @password << "new"
    @page.ResetPasswordTo @password

    @page = LoginPage.new
    @page.LoginWithInfo(@createdemail, @password).LogOut

  end
end

