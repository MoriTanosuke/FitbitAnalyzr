require 'spec_helper'

describe "custom_data/index" do
  before(:each) do
    assign(:custom_data, [
      stub_model(CustomDatum),
      stub_model(CustomDatum)
    ])
    assign(:mapped_values, [])
    view.stub(:will_paginate)
  end

  it "renders a list of custom_data" do
    render
  end
end
