require 'spec_helper'

describe "Users" do
  fixtures :users

  describe "register" do
    describe "failure" do
      it "should not create new user" do
        lambda do
          visit register_path
          fill_in "Email", :with => ''
          fill_in "Password", :with => ''
          fill_in "Confirm Password", :with => ''
          click_button
          response.should render_template('users/new')
          response.should have_selector('div#error_explanation')
        end.should_not change(User, :count)
      end
    end
  end

end
