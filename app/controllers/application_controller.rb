class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize, :set_locale

  protected

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def authorize
      unless current_user
        redirect_to login_url, :notice => "Please log in"
      end
    end

    def logged_in?
      session[:user_id] != nil
    end

    def current_user
      User.find_by_id(session[:user_id])
    end

    def today
      str(Time.now)
    end

    def str(date)
      date.strftime('%Y-%m-%d')
    end
end
