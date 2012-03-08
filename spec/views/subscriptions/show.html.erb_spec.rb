require 'spec_helper'

describe "subscriptions/show" do
  before(:each) do
    @subscription = assign(:subscription, stub_model(Subscription,
      :collection_path => "Collection Path",
      :subscription_id => "Subscription"
    ))
  end

  it "renders attributes in <p>" do
    pending('not yet implemented')
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Collection Path/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Subscription/)
  end
end
