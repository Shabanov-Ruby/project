class CarsController < ApplicationController
  before_action :set_car, only: %i[ show edit update destroy ]

  # GET /cars or /cars.json
  def index
    filtered_cars = CarFilterService.new(filter_params).call
    render json: filtered_cars
  end

  # GET /cars/1 or /cars/1.json
  def show
    @car = Car.find(params[:id])
    render json: @car
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
      params.permit(:brand_name, :model_name, :generation_id, :year_from, :max_price, :engine_type_id, :gearbox_type_id, :body_type_id, :drive_type_id, :owners_count)
    end
end
