require 'spec_helper'
require 'site_prism'
require 'signup_modal'
include Pages

feature 'User Login' do
  before(:all) do
    @rand = rand(1000).to_s
    @email = "testuser" + @rand + "@mailinator.com"
    @email2 =  "testuser" + @rand + @rand + "@mailinator.com"
    @password = 'Proto123'
    @firstname = 'TestUser'
    @lastname = 'ProtoTest'
    @page = SignupModal.new
  end
  before(:each) do
    @page.load
  end

  scenario 'Register a new account' do
    @page.
        EnterEmail(@email).
        EnterInfo(@firstname,@lastname,@password)
  end
  scenario 'Log In' do
    @page.
        Login.
        LoginWithInfo(@email,@password);
    page.should have_text ""
  end

  scenario 'Change Your Mind' do
    @page.
        EnterEmail(@email2).
        Back.
        EnterEmail(@email).
        EnterInfo(@firstname,@lastname,@password)
  end

  scenario 'Register Email that already exists' do
    @page.
        Login.
        JoinNow.
        EnterEmailThatAlreadyExists('asdf@asdf.com').
        EnterEmail(@email)
  end

  scenario 'Enter Blank Registration Info' do
    @page.
        Login.
        EnterBlankInfo
    page.should have_text 'Please enter a first name.'
    page.should have_text 'Please enter a last name.'
    page.should have_text 'Please enter a password between 6-16 characters long.'
  end
end

