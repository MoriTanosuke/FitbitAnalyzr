class SubscriptionsController < FitbitController
  skip_before_filter :authorize, :only => [:notify]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = current_user.subscriptions.order(:created_at)

    if not current_user.fitbit.nil?
      begin
        @fitbit_subscriptions = JSON.parse(current_user.fitbit.client.get('/1/user/-/apiSubscriptions.json').body)['apiSubscriptions']
      rescue SocketError
        logger.error "Can not talk to fitbit"
      end
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
    update = JSON.parse(request['updates'].read)
    puts "received notification #{update}"
    @notification = []
    update.each do |u|
      # trigger update
      date = u['date']
      sid = u['subscriptionId']
      series = u['collectionType']
      uid = sid[0, sid.index('-')]
      user = User.find_by_id(uid)
      if not user.nil?
        puts "update #{series} on #{date} for #{user.email}"
        data = reload_range_for_user(user, get_series(series), date, date)
        # TODO this needs clean up! I don't want to duplicate from activity/sleep/measurement_controller
        get_series(series).each do |s|
          puts "Updating series=#{s}"
          data[s].each do |day|
            puts "#{s} #{day['dateTime']}=#{day['value']}"
            if series == 'activities'
              update = Activity.find_by_date(day['dateTime'])
              if update.nil?
                update = Activity.new
              end
              update.date = date
              update.user = user
              update.send(s.partition('/')[2] + '=', day['value'])
              update.save
            elsif series == 'body'
              update = Measurement.find_by_date(day['dateTime'])
              if update.nil?
                update = Measurement.new
              end
              update.date = date
              update.user = user
              update.send(s.partition('/')[2] + '=', day['value'])
              update.save
            elsif series == 'sleep'
              update = Sleep.find_by_date(day['dateTime'])
              if update.nil?
                update = Sleep.new
              end
              update.date = date
              update.user = user
              update.send(s.partition('/')[2] + '=', day['value'])
              update.save
            end
          end
        end
      end
      @notification << u
    end
    SubscriptionMailer.notification_received(@notification.to_s.html_safe).deliver

    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end
end
