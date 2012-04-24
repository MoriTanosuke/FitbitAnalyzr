require 'spec_helper'

describe "foods/show" do
  before(:each) do
    @food = assign(:food, stub_model(Food))
  end

  it "renders attributes in <p>" do
    render
  end
end
