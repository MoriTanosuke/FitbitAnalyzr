class UsersController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = [User.find(current_user)]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:success] = 'You are registered. Please log in.'
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

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      # TODO check if fitbit token should be removed
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url, :notice => "User #{@user.email} was successfully updated." }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
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
  
  def deauthorize
    @user = current_user
    puts "Removing connection to fitbit from #{@user.email}"
    if not @user.nil? and not @user.fitbit.nil?
      puts "Removing fitbit #{@user.fitbit}"
      if @user.fitbit.delete
        flash[:success] = 'You are no longer connected to Fitbit'
      else
        flash[:failure] = 'Can not delete connection to Fitbit'
      end
    end
    redirect_to root_url
  end

end
