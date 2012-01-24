class SleepsController < ApplicationController
  # GET /sleeps
  # GET /sleeps.json
  def index
    @sleeps = Sleep.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @sleeps }
    end
  end

  # GET /sleeps/1
  # GET /sleeps/1.json
  def show
    @sleep = Sleep.find(params[:id])

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
    @sleep = Sleep.new(params[:sleep])

    data = reload(@sleep.date)
    @sleep.data = data
    sleep = JSON(data)['sleep'][0]
    @sleep.duration = sleep['duration']
    @sleep.awakeningscount = sleep['awakeningsCount']
    @sleep.minutesToFallAsleep = sleep['minutesToFallAsleep']
    @sleep.efficiency = sleep['efficiency']
    @sleep.minutesAsleep = sleep['minutesAsleep']
    @sleep.timeInBed = sleep['timeInBed']
    @sleep.startTime = sleep['startTime'].to_s
    @sleep.minutesAwake = sleep['minutesAwake']
    @sleep.minutesAfterWakeup = sleep['minutesAfterWakeup']

    respond_to do |format|
      if @sleep.save
        format.html { redirect_to @sleep, :notice => 'Sleep was successfully created.' }
        format.json { render :json => @sleep, :status => :created, :location => @sleep }
      else
        format.html { render :action => "new" }
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
    sleep = JSON(data)['sleep'][0]
    @sleep.duration = sleep['duration']
    @sleep.awakeningscount = sleep['awakeningsCount']
    @sleep.minutesToFallAsleep = sleep['minutesToFallAsleep']
    @sleep.efficiency = sleep['efficiency']
    @sleep.minutesAsleep = sleep['minutesAsleep']
    @sleep.timeInBed = sleep['timeInBed']
    @sleep.startTime = sleep['startTime'].to_s
    @sleep.minutesAwake = sleep['minutesAwake']
    @sleep.minutesAfterWakeup = sleep['minutesAfterWakeup']


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

  def reload(range)
    (current_user.fitbit.client.get('/1/user/-/sleep/date/' + today + '.json').body).as_json
  end
end

