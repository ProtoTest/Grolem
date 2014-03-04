require 'spec_helper'
require '../pages/signup_modal'
include Pages

feature 'User Authentication and Authorization' do

  context 'As a new user' do
    background do
      #clear cookies
    end
    scenario 'Register a new ac1count' do
      @page = SignupModal.new
      @page.load
      @page.Register("testuser12345@mailinator.com").
    end
    scenario 'Continue as guest' do
    end
  end

  context 'As a recurring user' do
    background do
    end
    scenario '' do
    end
    scenario '' do
    end
  end
end

