class HistoryCarsController < ApplicationController
  before_action :set_history_car, only: %i[ show edit update destroy ]

  # GET /history_cars or /history_cars.json
  def index
    @history_cars = HistoryCar.all
  end

  # GET /history_cars/1 or /history_cars/1.json
  def show
  end

  # GET /history_cars/new
  def new
    @history_car = HistoryCar.new
  end

  # GET /history_cars/1/edit
  def edit
  end

  # POST /history_cars or /history_cars.json
  def create
    @history_car = HistoryCar.new(history_car_params)

    respond_to do |format|
      if @history_car.save
        format.html { redirect_to @history_car, notice: "History car was successfully created." }
        format.json { render :show, status: :created, location: @history_car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @history_car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /history_cars/1 or /history_cars/1.json
  def update
    respond_to do |format|
      if @history_car.update(history_car_params)
        format.html { redirect_to @history_car, notice: "History car was successfully updated." }
        format.json { render :show, status: :ok, location: @history_car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @history_car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /history_cars/1 or /history_cars/1.json
  def destroy
    @history_car.destroy!

    respond_to do |format|
      format.html { redirect_to history_cars_path, status: :see_other, notice: "History car was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history_car
      @history_car = HistoryCar.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def history_car_params
      params.require(:history_car).permit(:car_id, :vin, :registration_number, :last_mileage, 
                                          :registration_restrictions, :registration_restrictions_info, 
                                          :wanted_status, :wanted_status_info, 
                                          :pledge_status, :pledge_status_info, 
                                          :previous_owners, 
                                          :accidents_found, :accidents_found_info, 
                                          :repair_estimates_found, :repair_estimates_found_info,
                                          :carsharing_usage, :carsharing_usage_info,
                                          :taxi_usage, :taxi_usage_info, 
                                          :diagnostics_found, :diagnostics_found_info, 
                                          :technical_inspection_found, :technical_inspection_found_info, 
                                          :imported, :imported_info, 
                                          :insurance_found, :insurance_found_info, 
                                          :recall_campaigns_found, :recall_campaigns_found_info)
    end
end
