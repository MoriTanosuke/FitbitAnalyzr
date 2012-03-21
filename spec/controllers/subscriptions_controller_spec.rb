require 'spec_helper'

describe SubscriptionsController do

  # This should return the minimal set of attributes required to create a valid
  # Subscription. As you add validations to Subscription, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SubscriptionsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "POST notify" do
    it "should acknowledge the notification with HTTP status code 204" do
      pending('post multipart/form with element "updates"')
      post 'notify' #, {:updates => fixture_file_upload('/textfile.txt', 'form/multipart')}
      response.response_code.should == 204
    end
  end
end
