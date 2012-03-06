require 'spec_helper'

describe "UserMailer" do
  fixtures :users

  before(:each) do
    ActionMailer::Base.deliveries = []
  end

  it "should send welcome mail on registration" do
    # TODO don't use UserMailer directly, use '/register' form
    UserMailer.welcome_email(users(:one)).deliver
    sent.first.subject.should =~ /welcome to fitbit analyzr/i
    sent.first.body.should =~ /your login is/i
    sent.first.body.should =~ /#{users(:one).email}/i
  end

  it "should send goodbye mail on account deletion" do
    # TODO don't use UserMailer directly, use '/delete' form
    UserMailer.goodbye_email(users(:one)).deliver
    sent.first.subject.should =~ /goodbye from fitbit analyzr/i
  end

  def sent
    ActionMailer::Base.deliveries
  end
end
