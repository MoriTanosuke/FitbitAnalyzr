require 'spec_helper'

describe "custom_data/show" do
  before(:each) do
    @custom_datum = assign(:custom_datum, stub_model(CustomDatum))
  end

  it "renders attributes in <p>" do
    render
  end
end
