class CustomDataController < ApplicationController
  # GET /custom_data
  # GET /custom_data.json
  def index
    @custom_data = current_user.custom_data.paginate :page => params[:page]
    @mapped_values = build_map @custom_data || []

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @custom_data }
    end
  end

  # GET /custom_data/1
  # GET /custom_data/1.json
  def show
    @custom_datum = CustomDatum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @custom_datum }
    end
  end

  # GET /custom_data/new
  # GET /custom_data/new.json
  def new
    @custom_datum = CustomDatum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @custom_datum }
    end
  end

  # GET /custom_data/1/edit
  def edit
    @custom_datum = CustomDatum.find(params[:id])
  end

  # POST /custom_data
  # POST /custom_data.json
  def create
    @custom_datum = CustomDatum.new(params[:custom_datum])
    @custom_datum.user_id = current_user.id

    respond_to do |format|
      if @custom_datum.save
        format.html { redirect_to @custom_datum, notice: 'Custom datum was successfully created.' }
        format.json { render json: @custom_datum, status: :created, location: @custom_datum }
      else
        format.html { render action: "new" }
        format.json { render json: @custom_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /custom_data/1
  # PUT /custom_data/1.json
  def update
    @custom_datum = CustomDatum.find(params[:id])

    respond_to do |format|
      if @custom_datum.update_attributes(params[:custom_datum])
        format.html { redirect_to @custom_datum, notice: 'Custom datum was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @custom_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_data/1
  # DELETE /custom_data/1.json
  def destroy
    @custom_datum = CustomDatum.find(params[:id])
    @custom_datum.destroy

    respond_to do |format|
      format.html { redirect_to custom_data_url }
      format.json { head :ok }
    end
  end

  def clear
    current_user.custom_data.each do |custom_datum|
      custom_datum.destroy
    end

    respond_to do |format|
      format.html { redirect_to custom_data_url }
      format.json { head :ok }
    end
  end

protected

  def build_map(data)
    series = []
    # get all uniq custom_data names and add them as series
    data.collect{|d| d.name}.uniq.each do |name|
      values = []
      current_user.custom_data.find_all_by_name(name).each do |c|
        values.push({:date => c.date, :value => c.value})
      end
      series.push({:name => name, :values => values})
    end

    return series
  end
end
