class RegistrationController < ApplicationController
  skip_filter :authorize, :only => [:index, :new, :create]

  def index
  
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:success] = 'Welcome to Fitbit Analyzr. You are registered. Please log in.'
        UserMailer.welcome_email(@user).deliver
        format.html { redirect_to root_path }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        flash[:error] = 'Can not register'
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if not current_user.nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
    @user.destroy
    reset_session

    respond_to do |format|
      flash[:success] = 'User removed.'
      UserMailer.goodbye_email(@user).deliver
      format.html { redirect_to root_path }
      format.json { head :ok }
    end
  end
 
end
