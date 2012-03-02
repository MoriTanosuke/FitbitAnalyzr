class MeasurementsController < FitbitController
  # GET /measurements
  # GET /measurements.json
  def index
    @measurements = current_user.measurements.order('date')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @measurements }
    end
  end

  # GET /measurements/1
  # GET /measurements/1.json
  def show
    @measurement = Measurement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @measurement }
    end
  end

  # GET /measurements/new
  # GET /measurements/new.json
  def new
    @measurement = Measurement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @measurement }
    end
  end

  # GET /measurements/1/edit
  def edit
    @measurement = Measurement.find(params[:id])
  end

  # POST /measurements
  # POST /measurements.json
  def create
    data = reload('body/weight', str(Date.strptime(params[:measurement].values.join("-"))))
    saved = false
    if not data.blank?
      data['body-weight'].each do |day|
        @measurement = Measurement.new
        @measurement.date = day['dateTime']
        @measurement.weight = day['value']
        @measurement.user = current_user
	if @measurement.weight > 0
          saved = @measurement.save
        end
      end
    end

    respond_to do |format|
      if saved
        format.html { redirect_to @measurement, :notice => 'Measurement was successfully created.' }
        format.json { render :json => @measurement, :status => :created, :location => @measurement }
      else
        format.html { render :action => "new" }
        format.json { render :json => @measurement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /measurements/1
  # PUT /measurements/1.json
  def update
    @measurement = Measurement.find(params[:id])

    respond_to do |format|
      if @measurement.update_attributes(params[:measurement])
        format.html { redirect_to @measurement, :notice => 'Measurement was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @measurement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /measurements/1
  # DELETE /measurements/1.json
  def destroy
    @measurement = Measurement.find(params[:id])
    @measurement.destroy

    respond_to do |format|
      format.html { redirect_to measurements_url }
      format.json { head :ok }
    end
  end

end
