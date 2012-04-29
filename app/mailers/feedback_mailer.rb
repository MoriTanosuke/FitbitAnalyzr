class FeedbackMailer < ActionMailer::Base
  default from: '"Carsten from Fitbit Analyzr" carsten@kopis.de'

  def feedback(data, sent_at = Time.now)
    @user = data[:email]
    @subject = data[:subject]
    @text = data[:text]
    @sent_at = sent_at
    mail(:to => 'carsten@kopis.de', :subject => "[FITBIT ANALYZR] Feedback: #{@subject}")
  end
end
