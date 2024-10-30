class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def index
    filtered_cars = CarFilterService.new(filter_params).call
    paginated_cars = filtered_cars.page(params[:page]).per(30)
    render json: paginated_cars, each_serializer: CarSerializer
  end


  def show
    render json: @car, serializer: CarSerializer
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  def last_cars
    @cars = Car.last(20)
    render json: @cars
  end

  def cars_count
    result = BrandModelGenerationCountService.call
    render json: result
  end

  def car_details
    brand_name = params[:brand_name]
    model_name = params[:model_name]
    generation_name = params[:generation_name]
    result = CarDetailService.call(brand_name, model_name, generation_name)
    render json: result
  end

  # POST /cars or /cars.json
  def create
    @car = Car.new(car_params)
    if @car.save
      render json: @car, status: :created
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cars/1 or /cars/1.json
  def update
    if @car.update(car_params)
      render json: @car, status: :ok
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cars/1 or /cars/1.json
  def destroy
    @car.destroy!
    render json: { message: "Car was successfully destroyed." }, status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:model_id, :brand_id, :year, :price, :description, 
                                  :color_id, :body_type_id, :engine_type_id, :gearbox_type_id, 
                                  :drive_type_id, :generation_id, :online_view_available)
    end

    def filter_params
      params.permit(:brand_name, :model_name, :generation_name, 
                    :year_from, :max_price, :gearbox_type_id, :body_type_id, 
                    :drive_type_id, :owners_count, :engine_type_name)
    end
end
