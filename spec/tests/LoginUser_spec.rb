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
    @firstname = "TestUser"
    @lastname = "ProtoTest"

    @page = SignupModal.new
  end

  before(:each) { @page.load }

  scenario 'Join as new User' do
    @page.
        EnterEmail(@newemail).
        EnterInfo(@firstname,@lastname,@password).ClosePanel
  end
  scenario 'Login as Existing Member' do
    @page.
        GoToLoginPage.
        LoginWithInfo(@newemail,@password).LogOut
  end

  scenario 'Login with Facebook' do
    @page.GoToLoginPage.GoToFacebookLogin.LoginAs(@facebookemail,@password).LogOut
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
    sleep 5
    @page = MailinatorPage.new
    @page.load(username: @rand_username)
    @page.ClickMailWithText 'Please Reset Your One Kings Lane Password'
    @page.ClickBodyText 'Click here to reset your password'
    @page = ResetPasswordPage.new

    @page.ResetPasswordTo(@password).LogOut
  end

   scenario 'Join -b' do
      @page = JoinBPage.new
      @page.load
      @page.GoToLoginPage.LoginWithInfo @newemail, @password
    end

    scenario 'Join -c' do
      @page = JoinCPage.new
      @page.load
      @page.GoToLoginPage
    end

  scenario 'Keep me logged in ' do
    @page

  end
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
      page.reset_session!
      @page = LoginPage.new
      @page.load
      @page.LoginWithInfo(@newemail, @password).LogOut
    end

end

