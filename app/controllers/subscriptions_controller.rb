class SubscriptionsController < ApplicationController
  skip_before_filter :notify

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all

    if not current_user.fitbit.nil?
      @fitbit_subscriptions = JSON.parse(current_user.fitbit.client.get('/1/user/-/apiSubscriptions.json').body)['apiSubscriptions']
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscriptions }
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.json
  def new
    @subscription = Subscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.created_at = Time.new
    @subscription.user_id = current_user.id
    @subscription.subscription_id = current_user.id.to_s
    respond_to do |format|
      if @subscription.save
        if not current_user.fitbit.nil?
          path = ['/1/user/-', @subscription.collection_path, 'apiSubscriptions', @subscription.subscription_id + '-' + @subscription.collection_path]
          api = JSON.parse(current_user.fitbit.client.post(path.join('/') + '.json').body)
          flash[:success] = 'Subscription was successfully created.' 
          format.html { redirect_to @subscription }
          format.json { render json: @subscription, status: :created, location: @subscription }
        end
      else
        flash[:error] << @subscription.errors
        format.html { render action: "new" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    if not current_user.fitbit.nil?
      path = ['/1/user/-', @subscription.collection_path, 'apiSubscriptions', @subscription.subscription_id + '-' + @subscription.collection_path]
      current_user.fitbit.client.delete(path.join('/') + '.json')
      flash[:success] = 'Subscription successfully removed from Fitbit.'
    else
      flash[:error] = 'Can not remove subscription from Fitbit, because you are not connected.'
    end
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :ok }
    end
  end

  def notify
    @notification = params
    logger.info "received notification"
    SubscriptionMailer.notification_received(@notification).deliver

    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end
end
