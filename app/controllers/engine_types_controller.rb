class EngineTypesController < ApplicationController
  before_action :set_engine_type, only: %i[ show edit update destroy ]

  # GET /engine_types or /engine_types.json
  def index
    @engine_types = EngineType.all 
    render json: @engine_types
  end

  # GET /engine_types/1 or /engine_types/1.json
  def show
    render json: @engine_type
  end

  # GET /engine_types/new
  def new
    @engine_type = EngineType.new
  end

  # GET /engine_types/1/edit
  def edit
    render json: @engine_type
  end

  # POST /engine_types or /engine_types.json
  def create
    @engine_type = EngineType.new(engine_type_params)

    if @engine_type.save
      render json: @engine_type, status: :created
    else
      render json: @engine_type.errors, status: :unprocessable_entity
    end
  end       

  # PATCH/PUT /engine_types/1 or /engine_types/1.json
  def update
    if @engine_type.update(engine_type_params)
      render json: @engine_type, status: :ok
    else
      render json: @engine_type.errors, status: :unprocessable_entity
    end
  end   

  # DELETE /engine_types/1 or /engine_types/1.json
  def destroy
    @engine_type.destroy!
    render json: { message: 'Engine type was successfully destroyed.' }, status: :see_other    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engine_type
      @engine_type = EngineType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def engine_type_params
      params.require(:engine_type).permit(:name, :engine_power, :engine_capacity)
    end
end
