require_all 'pages'

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
      @facebookpassword = 'Qubit123!'
      @page = SignupModal.new
    end

  before(:each) { @page.load }

  scenario 'Join as new User' do
    @page.
        EnterEmail(@email).
        EnterInfo(@firstname,@lastname,@password).ClosePanel.
  end
  scenario 'Login as Existing Member' do
    @page.
        GoToLoginPage.
        LoginWithInfo(@email,@password).
    page.should have_text ""
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
      @page

    end

  scenario 'Join -c' do
    @page

  end
  scenario 'Keep me logged in ' do
    @page

  end
  scenario 'Invite Friends' do
    @page

  end
  scenario '/Login' do
    @page

  end
end

