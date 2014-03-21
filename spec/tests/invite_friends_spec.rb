require 'rspec'

feature 'Invite Friends' do
  before(:all) do
    @rand = rand(1000).to_s
    @newemail = "testuser" + @rand + "@mailinator.com"
    @newemail2 =  "testuser" + @rand + @rand + "@mailinator.com"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @newemail = 'prototest@mailinator.com'
    @facebookemail = 'bkitchener@prototest.com'
    @facebookpassword = 'Qubit123!'
    @page = LoginPage.new
  end

  before(:each) { @page.load }

  #scenario 'Skip Invite' do
  #  @page
  #
  #end

  scenario 'Invite Friends' do
    @page.
        LoginWithInfo @facebookemail, @password
    @page = InvitePage.new
    @page.load
    @page.should be_all_there
    @page.SendInviteToEmails @newemail, 'this is the message i am sending'

    @page = MailinatorPage.new
    visit "http://mailinator.com/inbox.jsp?to=" + @rand_username
    @page.ClickMailWithText 'shop at One Kings Lane'
    @page.should have_text "this is the message i am sending"
    @page.ClickXpath '//img[@alt="Accept Invitation"]'
  end

  scenario 'Search shows up in header' do
    @page

  end

  scenario 'Search works' do
    @page

  end

  scenario 'Confirm credit' do
    @page

  end
  end
end