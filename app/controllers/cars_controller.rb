class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def index
    # Фильтрация автомобилей
    filtered_cars = CarFilterService.new(filter_params).call

    # Применение пагинации к отфильтрованным автомобилям
    paginated_cars = filtered_cars.page(params[:page]).per(30)

    # Рендеринг JSON с использованием сериализатора
    render json: paginated_cars, each_serializer: CarSerializer
  end


  def show
    render json: @car, serializer: CarSerializer

    # @brand = Brand.find_by(name: params[:brand_name])
    # return render json: { error: "Brand not found" }, status: :not_found unless @brand

    # if params[:model_name].present?
    #   @model = @brand.models.find_by(name: params[:model_name])
    #   return render json: { error: "Model not found" }, status: :not_found unless @model
    # end

    # if params[:generation_name].present?
    #   @generation = @model.generations.find_by(name: params[:generation_name])
    #   return render json: { error: "Generation not found" }, status: :not_found unless @generation
    # end

    # if params[:car_id].present?
    #   return render json: { error: "Invalid car ID" }, status: :bad_request unless params[:car_id].match?(/^\d+$/)

    #   @car = Car.find_by(id: params[:car_id])
    #   return render json: { error: "Car not found" }, status: :not_found unless @car

    #   render json: @car
    # else
    #   @cars = if @generation
    #             @generation.cars
    #           elsif @model
    #             @model.cars
    #           else
    #             @brand.cars
    #           end
    #   render json: @cars
    # end
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
    brand_model_generation_counts = Car.joins(:brand, :model, :generation)
                                       .group('brands.name', 'models.name', 'generations.name')
                                       .count

    brand_counts = Car.joins(:brand)
                      .group('brands.name')
                      .count

    result = brand_counts.each_with_object({}) do |(brand_name, total_count), hash|
      hash[brand_name] = { total: total_count, models: {} }
    end

    brand_model_generation_counts.each do |(brand_name, model_name, generation_name), count|
      result[brand_name][:models][model_name] ||= { total: 0, generations: {} }
      result[brand_name][:models][model_name][:total] += count
      result[brand_name][:models][model_name][:generations][generation_name] = count
    end

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
      params.permit(:brand_name, :model_name, :generation_name, :year_from, :max_price, :gearbox_type_id, :body_type_id, :drive_type_id, :owners_count, :engine_type_name)
    end
end
