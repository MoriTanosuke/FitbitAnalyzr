require 'spec_helper'

describe FoodsController do
  fixtures :users, :foods

   it "assigns all foods as @foods" do
    session[:user_id] = users(:one).id
    get 'index'
    assigns(:foods).should eq([])
    # TODO load fixtures into database before running spec!
  end

   it "assigns series as @series" do
    session[:user_id] = users(:one).id
    get 'index'
    assigns(:series).should eq(['caloriesIn', 'water'].collect{|s| 'foods/log/' + s})
  end
end
