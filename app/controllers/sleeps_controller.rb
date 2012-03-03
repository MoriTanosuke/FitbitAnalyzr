class SleepsController < FitbitController

  # GET /sleeps
  # GET /sleeps.json
  def index
    @sleeps = current_user.sleeps.order('date')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @sleeps }
    end
  end

  # GET /sleeps/1
  # GET /sleeps/1.json
  def show
    @sleep = current_user.sleeps.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @sleep }
    end
  end

  # GET /sleeps/new
  # GET /sleeps/new.json
  def new
    @sleep = Sleep.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @sleep }
    end
  end

  # GET /sleeps/1/edit
  def edit
    @sleep = Sleep.find(params[:id])
  end

  # POST /sleeps
  # POST /sleeps.json
  def create
    data = reload(get_series, str(Date.strptime(params[:sleep].values.join("-"))))
    get_series.each do |s|
      data[s].each do |day|
        @sleep = for_date(day['dateTime'])
	# get variable name from last part of series
        @sleep.send(s[/\/(.*)/, 1] + '=', day['value'])
        @sleep.save
      end
    end
 
    respond_to do |format|
      format.html { redirect_to sleeps_path, :notice => 'Sleep was successfully created.' }
      format.json { render :json => sleeps_path, :status => :created, :location => sleeps_path }
    end
  end

  # PUT /sleeps/1
  # PUT /sleeps/1.json
  def update
    @sleep = Sleep.find(params[:id])

    #TODO update data for this sleep entry

    respond_to do |format|
      if @sleep.update_attributes(params[:sleep])
        format.html { redirect_to @sleep, :notice => 'Sleep was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @sleep.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sleeps/1
  # DELETE /sleeps/1.json
  def destroy
    @sleep = Sleep.find(params[:id])
    @sleep.destroy

    respond_to do |format|
      format.html { redirect_to sleeps_url }
      format.json { head :ok }
    end
  end

protected
  def get_series
    ['sleep/startTime', 'sleep/timeInBed', 'sleep/minutesAsleep', 'sleep/awakeningsCount', 'sleep/minutesAwake', 'sleep/minutesToFallAsleep', 'sleep/minutesAfterWakeup', 'sleep/efficiency']
  end

  def for_date(date)
    @sleep = Sleep.find_by_date(date)
    if @sleep.nil? or @sleep.user_id != current_user.id
      @sleep = Sleep.new
      @sleep.date = date
      @sleep.user = current_user
    end
    return @sleep
  end
end

