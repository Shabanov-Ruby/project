class FuelTypesController < ApplicationController
  before_action :set_fuel_type, only: %i[ show edit update destroy ]

  # GET /fuel_types or /fuel_types.json
  def index
    @fuel_types = FuelType.all
  end

  # GET /fuel_types/1 or /fuel_types/1.json
  def show
  end

  # GET /fuel_types/new
  def new
    @fuel_type = FuelType.new
  end

  # GET /fuel_types/1/edit
  def edit
  end

  # POST /fuel_types or /fuel_types.json
  def create
    @fuel_type = FuelType.new(fuel_type_params)

    respond_to do |format|
      if @fuel_type.save
        format.html { redirect_to @fuel_type, notice: "Fuel type was successfully created." }
        format.json { render :show, status: :created, location: @fuel_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fuel_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fuel_types/1 or /fuel_types/1.json
  def update
    respond_to do |format|
      if @fuel_type.update(fuel_type_params)
        format.html { redirect_to @fuel_type, notice: "Fuel type was successfully updated." }
        format.json { render :show, status: :ok, location: @fuel_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fuel_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fuel_types/1 or /fuel_types/1.json
  def destroy
    @fuel_type.destroy!

    respond_to do |format|
      format.html { redirect_to fuel_types_path, status: :see_other, notice: "Fuel type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fuel_type
      @fuel_type = FuelType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fuel_type_params
      params.require(:fuel_type).permit(:name)
    end
end
