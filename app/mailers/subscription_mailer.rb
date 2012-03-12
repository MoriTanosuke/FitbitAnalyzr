class SubscriptionMailer < ActionMailer::Base
  default from: '"Carsten from Fitbit Analyzr" <carsten@kopis.de>'

  def notification_received(notify)
    @notification = notify
    mail(:to => 'carsten@kopis.de', :subject => 'Notification received')
  end
end
