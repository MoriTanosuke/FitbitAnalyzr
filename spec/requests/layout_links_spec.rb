require 'spec_helper'

describe 'LayoutLinks' do
  it "should have a register page at '/register'" do
    get '/register'
    response.should have_selector('input', :id => 'user_email')
    response.should have_selector('input', :id => 'user_password')
  end

  it "should have a 'login' link at '/'" do
    get '/'
    response.should have_selector('a', :content => 'Log in')
    response.should have_selector('a', :href => '/login')
  end

  it "should have a 'register' link at '/'" do
    get '/'
    response.should have_selector('a', :content => 'Register')
    response.should have_selector('a', :href => '/register')
  end

  it "should have a 'donate' button" do
    get '/'
    response.should have_selector('form', :id => 'donate')
  end

  it "should have a 'privacy' link at '/'" do
    get '/'
    response.should have_selector('a', :content => 'Privacy')
  end
end

