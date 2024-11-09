class CarsController < ApplicationController
  before_action :set_car, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    if params[:page] == 'all'
      paginated_cars_all = CarFilterService.new(filter_params, per_page).all_cars
      render json: paginated_cars_all, each_serializer: CarSerializer
    else
      per_page = 18
      filtered_cars = CarFilterService.new(filter_params, per_page).call
      paginated_cars = filtered_cars.page(params[:page]).per(params[:per_page] || per_page)
      render json: paginated_cars, each_serializer: CarSerializer
    end
    
  end

  def show
    render json: @car, serializer: CarSerializer
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      render json: @car, status: :created
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  def update
    if @car.update(car_params)
      render json: @car, status: :ok
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @car.destroy
      head :ok
    else
      render json: @car.errors, status: :internal_server_error
    end
  end

  def total_pages
    per_page = 18
    total_pages = CarFilterService.new(filter_params, per_page).total_pages
    cars_count = CarFilterService.new(filter_params, per_page).cars_count
    render json: { total_pages: total_pages, cars_count: cars_count }
  end

  def last_cars
    @cars = Car.last(20)
    render json: @cars
  end

  def cars_count
    result = BrandModelGenerationCountService.call
    render json: result
  end

  def filters
    filters = params.permit(:brand_name, :model_name, :generation_name, 
                           :year_from, :max_price, :gearbox_type_name, :body_type_name, 
                           :drive_type_name, :owners_count, :engine_type_name)
    result = CarFilterDataService.call(filters)
    render json: result
  end


  def car_details
    brand_name = params[:brand_name]
    model_name = params[:model_name]
    generation_name = params[:generation_name]
    result = CarDetailService.call(brand_name, model_name, generation_name)
    render json: result
  end

  private
    def set_car
      @car = Car.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Машина не найдена' }, status: :not_found
    end

    def car_params
      params.require(:car).permit(:model_id, :brand_id, :year, :price, :description, 
                                  :color_id, :body_type_id, :engine_type_id, :gearbox_type_id, 
                                  :drive_type_id, :generation_id, :online_view_available, :complectation_name)
    end

    def filter_params
      params.permit(:brand_name, :model_name, :generation_name, 
                    :year_from, :max_price, :gearbox_type_name, :body_type_name, 
                    :drive_type_name, :owners_count, :engine_type_name)
    end    
end

