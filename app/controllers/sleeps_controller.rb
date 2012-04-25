class SleepsController < FitbitController

  # GET /sleeps
  # GET /sleeps.json
  def index
    @sleeps = current_user.sleeps.paginate :page => params[:page], :order => 'date ASC'

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

  # POST /sleeps
  # POST /sleeps.json
  def create
    data = reload(get_series('sleep'), str(Date.strptime(params[:sleep].values.join("-"))))
    saved = false
    get_series('sleep').each do |s|
      data[s].each do |day|
        @sleep = for_date(day['dateTime'])
	# get variable name from last part of series
        @sleep.send(s.rpartition('/')[2] + '=', day['value'])
        saved = @sleep.save
      end
    end
 
    respond_to do |format|
      flash[:success] = 'Sleep was successfully created.'
      format.html { redirect_to sleeps_path }
      format.json { render :json => sleeps_path, :status => :created, :location => sleeps_path }
    end
  end

  # DELETE /sleeps/1
  # DELETE /sleeps/1.json
  def destroy
    @sleep = current_user.sleeps.find(params[:id])
    @sleep.destroy

    respond_to do |format|
      format.html { redirect_to sleeps_url }
      format.json { head :ok }
    end
  end

  def clear
    current_user.sleeps.each do |s|
      s.destroy
    end

    flash[:success] = 'All sleeps removed.'

    respond_to do |format|
      format.html { redirect_to foods_url }
      format.json { head :ok }
    end
  end


protected
  def for_date(date)
    sleep = current_user.sleeps.find_by_date(date)
    if sleep.nil? or sleep.user != current_user
      sleep = Sleep.new
      sleep.date = date
      sleep.user = current_user
    end
    return sleep
  end
end

