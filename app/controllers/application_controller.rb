class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize, :set_locale

  protected

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def authorize
      unless current_user
        flash[:error] = 'You are not authorized to view that page.'
        redirect_to login_url
      end
    end

    def logged_in?
      session[:user_id] != nil
    end

    def require_admin
      unless current_user.role == 'admin'
        redirect_to "/", notice: "You are not allowed to view that page"
      end
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

    def clean_user(user_id)
      current_user = User.find_by_id(user_id)
      current_user.sleeps.where("date < date('#{Date.today - 31}')").each do |a|
        a.delete
      end
      current_user.foods.where("date < date('#{Date.today - 31}')").each do |a|
        a.delete
      end
      current_user.activities.where("date < date('#{Date.today - 31}')").each do |a|
        a.delete
      end
      current_user.measurements.where("date < date('#{Date.today - 31}')").each do |a|
        a.delete
      end
    end
end
