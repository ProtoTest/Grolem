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
      @facebookpassword = 'Qubit123!'
      @page = SignupModal.new
    end

  before(:each) { @page.load }

  scenario 'Join as new User' do
    @page.
        EnterEmail(@email).
        EnterInfo(@firstname,@lastname,@password).ClosePanel
  end
  scenario 'Login as Existing Member' do
    @page.
        GoToLoginPage.
        LoginWithInfo(@email,@password).LogOut
  end

  scenario 'Login with Facebook' do
    @page.GoToLoginPage.GoToFacebookLogin.LoginAs(facebookemail,@facebookpassword).LogOut
  end

    scenario 'Guest Pass' do
      @page = GuestHomePage.new
      @page.load
      @page.logged_out_header.should be_all_there
    end

  scenario 'Forgot Password' do
    @page = LoginPage.new
    @page.load
    @page.ForgotPassword @createdemail
    sleep 5
    @page = MailinatorPage.new
    @page.load
    @page.ClickMailWithText 'Please Reset Your One Kings Lane Password'
    @page.ClickBodyText 'Click here to reset your password'
    @page = ResetPasswordPage.new

    @page.ResetPasswordTo(@password).LogOut
  end

   scenario 'Join -b' do
      @page = JoinBPage.new
      @page.load
      @page.GoToLoginPage
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
    @page.SendInviteToEmails @email, 'this is the message i am sending'

    @page = MailinatorPage.new
    visit "http://mailinator.com/inbox.jsp?to=" + @username
    @page.ClickMailWithText 'shop at One Kings Lane'
    @page.ClickXpath '//img[@alt="Accept Invitation"]'
  end

    scenario '/Login' do
      @page = LoginPage.new
      @page.load
      @page.LoginWithInfo(@facebookemail, @password).LogOut
    end

end

