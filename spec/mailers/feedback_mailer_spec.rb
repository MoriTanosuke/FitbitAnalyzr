require "spec_helper"

describe FeedbackMailer do
  fixtures :users

  before(:each) do
    ActionMailer::Base.deliveries = []
  end

  it "should send feedback mail" do
    #don't call recaptcha, but assume correct
    stub(:verify_recaptcha) {
      true
    }
    FeedbackMailer.feedback({:email => users(:one).email, :subject => "Test subject", :text => "Test text"}).deliver
    sent.first.body.should =~ /#{users(:one).email}/i
  end

  def sent
    ActionMailer::Base.deliveries
  end
end
