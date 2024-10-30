class FuelTypesController < ApplicationController
  before_action :set_fuel_type, only: %i[ show edit update destroy ]

  # GET /fuel_types or /fuel_types.json
  def index
    @fuel_types = FuelType.all
    render json: @fuel_types
  end

  # GET /fuel_types/1 or /fuel_types/1.json
  def show
    render json: @fuel_type
  end

  # GET /fuel_types/new
  def new
    @fuel_type = FuelType.new
  end

  # GET /fuel_types/1/edit
  def edit
    render json: @fuel_type
  end

  # POST /fuel_types or /fuel_types.json
  def create
    @fuel_type = FuelType.new(fuel_type_params)

    if @fuel_type.save
        render json: @fuel_type, status: :created
    else
      render json: @fuel_type.errors, status: :unprocessable_entity
    end   
  end

  # PATCH/PUT /fuel_types/1 or /fuel_types/1.json
  def update  
    if @fuel_type.update(fuel_type_params)
      render json: @fuel_type, status: :ok
    else  
      render json: @fuel_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /fuel_types/1 or /fuel_types/1.json
  def destroy
    if @fuel_type.destroy!
      render json: { message: 'Fuel type was successfully destroyed.' }, status: :see_other    
    else
      render json: @fuel_type.errors, status: :unprocessable_entity
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
