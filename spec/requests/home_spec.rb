require 'spec_helper'

describe "home page" do
  it "displays the navigation" do
    get "/"
    assert_select "header ul" do |links|
      links.each do |link|
        assert_select link, "li", 4
      end
    end
  end

  it "displays the users username after successful login" do
    user = User.create(:name => 'john', :password => 'doe')
    get '/login'
    assert_select "form" do
      assert_select "input[name=?]", "name"
      assert_select "input[name=?]", "password"
      #make sure submit button is available
      assert_select "input[type=?]", "submit"
    end
    
    post '/login', :name => 'john', :password => 'doe'
    get '/'
    assert_select ".username", :text => 'john'
  end
end

