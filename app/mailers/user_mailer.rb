class UserMailer < ActionMailer::Base
  default from: '"Carsten from Fitbit Analyzr" carsten@kopis.de'

  def welcome_email(user)
    @user = user
    @url = 'http://floating-sunrise-1622.heroku.com/login'
    mail(:to => user.email, :subject => 'Welcome to Fitbit Analyzr')
  end

  def goodbye_email(user)
    @user = user
    @feedback_url = ''
    mail(:to => @user.email, :subject => 'Goodbye from Fitbit Analyzr')
  end
end
