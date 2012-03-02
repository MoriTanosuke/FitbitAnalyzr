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
    saved = false
    data = reload('sleep/minutesAsleep', str(Date.strptime(params[:sleep].values.join("-"))))
    if not data['sleep-minutesAsleep'].blank?
      data['sleep-minutesAsleep'].each do |day|
        logger.info day['dateTime'] + "=" + day['value']
        @sleep = Sleep.new
        @sleep.date = day['dateTime']
        @sleep.minutesAsleep = day['value']
        @sleep.user = current_user
        saved = @sleep.save
      end
    end
 
    respond_to do |format|
      if saved
        format.html { redirect_to @sleep, :notice => 'Sleep was successfully created.' }
        format.json { render :json => @sleep, :status => :created, :location => @sleep }
      else
        format.html { render :action => "new", :notice => 'Can not save data' }
        format.json { render :json => @sleep.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sleeps/1
  # PUT /sleeps/1.json
  def update
    @sleep = Sleep.find(params[:id])

    data = reload(@sleep.date)
    @sleep.data = data
    if not data.nil? and not s['sleep'].blank?
      s = JSON(data)
      sleep = s['sleep'][0]
      @sleep.duration = sleep['duration']
      @sleep.awakeningscount = sleep['awakeningsCount']
      @sleep.minutesToFallAsleep = sleep['minutesToFallAsleep']
      @sleep.efficiency = sleep['efficiency']
      @sleep.minutesAsleep = sleep['minutesAsleep']
      @sleep.timeInBed = sleep['timeInBed']
      @sleep.startTime = sleep['startTime'].to_s
      @sleep.minutesAwake = sleep['minutesAwake']
      @sleep.minutesAfterWakeup = sleep['minutesAfterWakeup']
    end


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
end

