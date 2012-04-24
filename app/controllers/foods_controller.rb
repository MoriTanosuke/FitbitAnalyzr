class FoodsController < FitbitController
  # GET /foods
  # GET /foods.json
  def index
    @foods = current_user.foods.paginate :page => params[:page], :order => 'date asc'
    @series = get_series('foods')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @foods }
    end
  end

  # GET /foods/1
  # GET /foods/1.json
  def show
    @food = Food.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @food }
    end
  end

  # GET /foods/new
  # GET /foods/new.json
  def new
    @food = Food.new
    @series = get_series('foods')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @food }
    end
  end

  # POST /foods
  # POST /foods.json
  def create
    data = reload(get_series('foods'), str(Date.strptime(params[:food].values.join("-"))))
    saved = false
    get_series('foods').each do |s|
      puts "Updating series=#{s}"
      data[s].each do |day|
        @food = for_date(day['dateTime'])
        @food.send(s.rpartition('/')[2] + '=', day['value'])
        saved = @food.save
        if not saved
          flash[:error] = @food.errors
        end
      end
    end

    respond_to do |format|
      flash[:success] = 'Food was successfully created.'
      format.html { redirect_to @food }
      format.json { render json: @food, status: :created, location: @food }
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.json
  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    respond_to do |format|
      format.html { redirect_to foods_url }
      format.json { head :ok }
    end
  end

protected
  def for_date(date)
    a = current_user.foods.find_by_date(date)
    if a.nil? or a.user != current_user
      a = Food.new
      a.date = date
      a.user = current_user
    end
    return a
  end
end
