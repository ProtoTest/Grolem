require 'spec_helper'
require 'login_page'
require 'mailinator_page'
include Pages


feature 'User Login' do
  before(:all) do
    @rand = rand(1000).to_s
    @username = "testuser" + @rand
    @email =  @username + "@mailinator.com"
    @email2 =  @username + @rand + "@mailinator.com"
    @password = "Proto123!"
    @firstname = "TestUser"
    @lastname = "ProtoTest"
    @createdemail = "prototest@mailinator.com"
    @facebookemail = "bkitchener@prototest.com"
  end
  scenario 'Invite Friends' do
    @page = SignupModal.new
    @page.load
    @page.
        GoToLoginPage.
        LoginWithInfo @facebookemail, @password
    @page = InvitePage.new
    @page.load
    @page.SendInviteToEmails @email, 'this is the message i am sending'

    @page = MailinatorPage.new
    visit "http://mailinator.com/inbox.jsp?to=" + @username

    sleep 20
    @page.ClickMailWithText 'shop at One Kings Lane'
    @page.ClickXpath '//img[@alt="Accept Invitation"]'
  end
end

