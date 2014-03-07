require 'spec_helper'
require 'site_prism'
require 'signup_modal'
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

  scenario 'Register a new account' do
    @page.load
    @page = @page.
        EnterEmail(@email).
        EnterInfo(@firstname,@lastname,@password)
  end
  scenario 'Log In' do
    @page.load
    @page.
        Login.
        LoginWithInfo(@email,@password).
        ClosePanel
  end

  scenario 'Change Your Mind' do
    @page.load
    @page.
        Login.
        JoinNow.
        EnterEmail('slkdfj@lsasdfasdfdasfdkfjslk.com').
        Back.
        EnterEmail(@email)
  end

  scenario 'Register Email that already exists' do
    @page.load
    @page.
        Login.
        JoinNow.
        EnterEmailThatAlreadyExists('asdf@asdf.com').
        EnterEmail(@email)
  end

  scenario 'Enter Blank Registration Info' do
    @page.load
    @page.EnterEmail(@email).
        EnterBlankInfo
    page.should have_text 'Please enter a first name.'
    page.should have_text 'Please enter a last name.'
    page.should have_text 'Please enter a password between 6-16 characters long.'
  end
end

