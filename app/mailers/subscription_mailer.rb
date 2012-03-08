class SubscriptionMailer < ActionMailer::Base
  default from: '"Carsten from Fitbit Analyzr" <carsten@kopis.de>'

  def notification_received(user)
    @user = user
    mail(:to => 'carsten@kopis.de', :subject => 'Notification received')
  end
end
