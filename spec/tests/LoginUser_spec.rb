require 'spec_helper'

feature 'User Login' do
  before(:all) do
    @rand = rand(1000).to_s
    @rand_username = "testuser" + @rand
    @rand_username2 = "testuser" + @rand + @rand
    @newemail =  @rand_username + "@mailinator.com"
    @newemail2 =  @rand_username2 + "@mailinator.com"
    @email = "prototest@mailinator.com"
    @facebookemail = "bkitchener@prototest.com"
    @password = "Proto123!"
    @newpassword = "Test123!"
    @firstname = "TestUser"
    @lastname = "ProtoTest"
   @page = SignupModal.new
  end

  before(:each) do
   @page.load
  end

  scenario 'Join as new User' do
    @page.
        EnterEmail(@newemail).
        EnterInfo(@firstname,@lastname,@password).
        ClosePanel
  end
  scenario 'Login as Existing Member' do
    @page.
        GoToLoginPage.
        LoginWithInfo(@email,@password).
        LogOut
  end

  scenario 'Login with Facebook' do
    @page = LoginPage.new
    @page.load
    @page.GoToFacebookLogin.
        LoginAs(@facebookemail,@password).
        LogOut
  end

    scenario 'Guest Pass' do
      @page = GuestHomePage.new
      @page.load
      @page.header.should be_all_there
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

  scenario 'Join' do
    @page = SignUpPage.new
    @page.load
    @page.EnterInfo(@firstname,@lastname,@email,@password,'').
        LogOut
  end

  scenario 'Join -b' do
      @page = JoinBPage.new
      @page.load
      @page.GoToLoginPage.
          LoginWithInfo(@email, @password).
          LogOut
    end

    scenario 'Join -c' do
      @page = JoinCPage.new
      @page.load
      @page.GoToLoginPage.
          LoginWithInfo(@email, @password).
          LogOut
    end

=begin
# THIS scenario is testing in the session_spec
  scenario 'Keep me logged in ' do
    @page

  end
=end

  scenario 'Invite Friends' do
    @page = SignupModal.new
    @page.load
    @page.
        GoToLoginPage.
        LoginWithInfo @facebookemail, @password
    @page = InvitePage.new
    @page.load
    @page.SendInviteToEmails @newemail2, 'this is the message i am sending'

    @page = MailinatorPage.new
    @page.load(username:@rand_username2)
    @page.ClickMailWithText 'shop at One Kings Lane'
    @page.ClickXpath '//img[@alt="Accept Invitation"]'
  end

  scenario '/Login' do
      @page = LoginPage.new
      @page.load
      @page.LoginWithInfo(@email, @password).
          LogOut
    end

end

