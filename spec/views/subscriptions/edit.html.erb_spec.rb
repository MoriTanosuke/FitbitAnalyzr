require 'spec_helper'

describe "subscriptions/edit" do
  before(:each) do
    @subscription = assign(:subscription, stub_model(Subscription,
      :collection_path => "MyString",
      :subscription_id => "MyString"
    ))
  end

  it "renders the edit subscription form" do
    pending('not yet implemented')
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => subscriptions_path(@subscription), :method => "post" do
      assert_select "input#subscription_collection_path", :name => "subscription[collection_path]"
      assert_select "input#subscription_subscription_id", :name => "subscription[subscription_id]"
    end
  end
end
