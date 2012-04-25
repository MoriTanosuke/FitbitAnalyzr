class ActivitiesController < FitbitController
  # GET /activities
  # GET /activities.json
  def index
    @activities = current_user.activities.paginate :page => params[:page], :order => 'date ASC'
    @series = get_series('activities')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
      if current_user.subscribed?
        format.csv { render :layout => false }
      else
        # don't respond
        format.csv { head :no_content }
      end
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = current_user.activities.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = Activity.new
    @series = get_series('activities')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # POST /activities
  # POST /activities.json
  def create
    data = reload(get_series('activities'), str(Date.strptime(params[:activity].values.join("-"))))
    saved = false
    get_series('activities').each do |s|
      puts "Updating series=#{s}"
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
      flash[:success] = 'Activity was successfully created.'
      format.html { redirect_to @activity }
      format.json { render json: @activity, status: :created, location: @activity }
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity = current_user.activities.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :ok }
    end
  end

  def clear
    current_user.activities.each do |a|
      a.destroy
    end

    flash[:success] = 'All activities removed.'

    respond_to do |format|
      format.html { redirect_to foods_url }
      format.json { head :ok }
    end
  end


protected
  def for_date(date)
    a = current_user.activities.find_by_date(date)
    if a.nil? or a.user != current_user
      a = Activity.new
      a.date = date
      a.user = current_user
    end
    return a
  end

end
