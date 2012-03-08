require 'spec_helper'

describe "subscriptions/new" do
  before(:each) do
    assign(:subscription, stub_model(Subscription,
      :collection_path => "MyString",
      :subscription_id => "MyString"
    ).as_new_record)
  end

  it "renders new subscription form" do
    pending('not yet implemented')
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => subscriptions_path, :method => "post" do
      assert_select "input#subscription_collection_path", :name => "subscription[collection_path]"
      assert_select "input#subscription_subscription_id", :name => "subscription[subscription_id]"
    end
  end
end
