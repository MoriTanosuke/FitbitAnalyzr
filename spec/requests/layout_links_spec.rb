require 'spec_helper'

describe 'LayoutLinks' do
  it "should have a register page at '/register'" do
    get '/register'
    response.should have_selector('input', :id => 'user_email')
    response.should have_selector('input', :id => 'user_password')
  end
end

