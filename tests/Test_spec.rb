require "../core/base_page"
require "../pages/signup_modal"
include Pages

feature 'User Login' do
  before(:all) do
    @rand = rand(1000).to_s
    @email = "testuser" + @rand + "@mailinator.com"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @page = SignupModal.new
  end

  scenario 'Log In' do
    @page.load
    @page.
        Login.
        LoginWithInfo(@email,@password).
        ClosePanel
  end

end

