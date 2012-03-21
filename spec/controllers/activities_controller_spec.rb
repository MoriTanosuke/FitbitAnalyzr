require 'spec_helper'

describe ActivitiesController do
  fixtures :users

  it "should return :no_content for CSV if not subscribed" do
    session[:user_id] = users(:one).id
    get 'index', :format => 'csv'
    response.response_code.should == 204
  end

  it "should return CSV if subscribed" do
    session[:user_id] = users(:two).id
    get 'index', :format => 'csv'
    response.response_code.should == 200
    response.content_type.should == 'text/csv'
  end

end

