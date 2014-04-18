require 'spec_helper'

feature 'Invite Friends' do
  before(:all) do
    @rand = rand(1000).to_s
    @new_customer = "testuser" + @rand + "@mailinator.com"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @facebookemail = 'msiwiec@prototest.com'
    @facebookpassword = 'Proto123'
  end

  before(:each) { }

  after(:each) {sleep 3;}

  # Skip what invite?
  #scenario 'Skip Invite' do
  #  @page
  #
  #end

  scenario 'Invite Friends' do
    # Create/Verify the facebook email user account is created
    # You can only invite new customers from an account that isn't disposable
    register_user(@firstname, @lastname, @facebookpassword, @facebookemail)

    @page = LoginPage.new
    @page.load

    @page.LoginWithInfo @facebookemail, @facebookpassword
    @page = InvitePage.new
    @page.load
    @page.should be_all_there
    @page.SendInviteToEmails(@new_customer, 'this is the message i am sending').header.LogOut

    # Reset the session and cookies so the invitee can claim the credit
    reset_capybara


    # visit the mailinator page, with just the username, not the domain
    visit "http://mailinator.com/inbox.jsp?to=#{@new_customer.gsub(/@mailinator.com/, '')}"

    @page = MailinatorPage.new.ClickMailWithText 'shop at One Kings Lane'
    within_frame(find('#mailshowdivbody>iframe')) do
      @page.should have_text "this is the message i am sending"
      @page.ClickXpath '//img[@alt="Accept Invitation"]'

      @page = SignupModal.new.wait_for_elements.
          VerifyInviteSignupModalDisplayed.
          EnterEmail(@new_customer).
          EnterInfo(@firstname,@lastname,@password).
          ClosePanel
    end
  end

  scenario 'Search is displayed in header and works' do
    #There is no search box on the mobile page - using desktop page
    @page = LoginPage.new
    @page.load

    @page.LoginWithInfo(@new_customer, @password).
        header.SearchFor("lamp").
        GoToFirstProduct(:available)
  end


  scenario 'Confirm credit' do
    @page = LoginPage.new
    @page.load

    @page.LoginWithInfo(@new_customer, @password).
        header.VerifyReferralAndCredits.
        header.SearchFor("lamp").
        GoToFirstProduct(:available).
        AddToCart.
        header.GoToCart.VerifyReferralCreditApplied
  end
end