require 'spec_helper'

describe "foods/index" do
  before(:each) do
    assign(:foods, [
# TODO is it necessary to stub with values?
      stub_model(Food, :caloriesIn => 1, :carbs => 1, :protein => 1, :fat => 1, :fiber => 1),
      stub_model(Food, :caloriesIn => 2, :carbs => 1, :protein => 1, :fat => 1, :fiber => 1)
    ])
    assign(:series, ['foods/log/caloriesIn'])
    view.stub(:will_paginate)
  end

  it "renders a list of foods" do
    render
  end
end
