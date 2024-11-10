class EnginePowerTypesController < ApplicationController
  before_action :set_engine_power_type, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    @engine_power_types = EnginePowerType.all
    render json: @engine_power_types
  end

  def show
    render json: @engine_power_type
  end

  def create
    @engine_power_type = EnginePowerType.new(engine_power_type_params)

    if @engine_power_type.save
      render json: @engine_power_type, status: :created
    else
      render json: @engine_power_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /engine_power_types/1 or /engine_power_types/1.json
  def update
    if @engine_power_type.update(engine_power_type_params)
      render json: @engine_power_type, status: :ok
    else
      render json: @engine_power_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /engine_power_types/1 or /engine_power_types/1.json
  def destroy
    if @engine_power_type.destroy!
      render status: :ok
    else
      render status: :internal_server_error
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engine_power_type
      @engine_power_type = EnginePowerType.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render status: :not_found
    end

    # Only allow a list of trusted parameters through.
    def engine_power_type_params
      params.require(:engine_power_type).permit(:power)
    end
end
