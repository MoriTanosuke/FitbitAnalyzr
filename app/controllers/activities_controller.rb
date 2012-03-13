class ActivitiesController < FitbitController
  # GET /activities
  # GET /activities.json
  def index
    @activities = current_user.activities.order(:date)
    @series = get_series

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }

      if current_user.subscribed?
        format.csv { render :layout => false }
      end
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = Activity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
  end

  # POST /activities
  # POST /activities.json
  def create
    data = reload(get_series, str(Date.strptime(params[:activity].values.join("-"))))
    saved = false
    get_series.each do |s|
      logger.info "Updating series=#{s}"
      data[s].each do |day|
        @activity = for_date(day['dateTime'])
        @activity.send(s.partition('/')[2] + '=', day['value'])
        saved = @activity.save
        if not saved
          flash[:error] = @activity.errors
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
      format.json { render json: @activity, status: :created, location: @activity }
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :ok }
    end
  end

protected

  def get_series
    ['calories', 'steps', 'distance', 'minutesSedentary', 'minutesLightlyActive', 'minutesFairlyActive', 'minutesVeryActive', 'activeScore', 'activityCalories'].collect {|s| 'activities/' + s}
    #'elevation', 'floors', 
  end

  def for_date(date)
    a = Activity.find_by_date(date)
    if a.nil? or a.user != current_user
      a = Activity.new
      a.date = date
      a.user = current_user
    end
    return a
  end

end
