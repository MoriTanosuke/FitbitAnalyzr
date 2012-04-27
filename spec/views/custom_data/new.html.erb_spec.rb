require 'spec_helper'

describe "custom_data/new" do
  before(:each) do
    assign(:custom_datum, stub_model(CustomDatum).as_new_record)
  end

  it "renders new custom_datum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => custom_data_path, :method => "post" do
    end
  end
end
