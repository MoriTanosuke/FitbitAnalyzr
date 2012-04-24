require 'spec_helper'

describe "foods/index" do
  before(:each) do
    assign(:foods, [
      stub_model(Food),
      stub_model(Food)
    ])
    assign(:series, [])
    view.stub(:will_paginate)
  end

  it "renders a list of foods" do
    render
  end
end
