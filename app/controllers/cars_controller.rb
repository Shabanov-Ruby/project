class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def index
    filtered_cars = CarFilterService.new(filter_params).call
    render json: filtered_cars
  end


  def show
    render json: @car

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

  # POST /cars or /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: "Car was successfully created." }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1 or /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: "Car was successfully updated." }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1 or /cars/1.json
  def destroy
    @car.destroy!

    respond_to do |format|
      format.html { redirect_to cars_path, status: :see_other, notice: "Car was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:model_id, :brand_id, :year, :price, :description, :color_id, :body_type_id, :engine_type_id, :gearbox_type_id, :drive_type_id, :fuel_type_id)
    end

    def filter_params
      params.permit(:brand_name, :model_name, :generation_name, :year_from, :max_price, :engine_type_id, :gearbox_type_id, :body_type_id, :drive_type_id, :owners_count)
    end
end
