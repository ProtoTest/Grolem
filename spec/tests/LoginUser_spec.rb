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
        Login.
        LoginWithInfo(@email,@password).
    page.should have_text ""
  end

  scenario 'Login with Facebook' do
    @page.Login.LoginWtihFacebook.LoginAs(facebookemail,@facebookpassword).LogOut
  end

  scenario 'Guest Pass' do
    @page

  end

  scenario 'Forgot Password' do
    @page = LoginPage.new
    @page.load
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

