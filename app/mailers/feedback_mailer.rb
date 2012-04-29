class FeedbackMailer < ActionMailer::Base
  default from: '"Carsten from Fitbit Analyzr" carsten@kopis.de'

  def feedback(user, subject, text, sent_at = Time.now)
    @user = user
    @text = text
    @sent_at = sent_at
    mail(:to => 'carsten@kopis.de', :subject => "[FITBIT ANALYZR] Feedback: #{subject}")
  end
end
