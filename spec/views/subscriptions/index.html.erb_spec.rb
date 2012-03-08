require 'spec_helper'

describe "subscriptions/index" do
  before(:each) do
    assign(:subscriptions, [
      stub_model(Subscription,
        :collection_path => "Collection Path",
        :subscription_id => "Subscription"
      ),
      stub_model(Subscription,
        :collection_path => "Collection Path",
        :subscription_id => "Subscription"
      )
    ])
  end

  it "renders a list of subscriptions" do
    pending('not yet implemented')
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Collection Path".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subscription".to_s, :count => 2
  end
end
