require 'spec_helper'

describe "custom_data/edit" do
  before(:each) do
    @custom_datum = assign(:custom_datum, stub_model(CustomDatum))
  end

  it "renders the edit custom_datum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => custom_data_path(@custom_datum), :method => "post" do
    end
  end
end
