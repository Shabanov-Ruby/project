class GearboxTypesController < ApplicationController
  before_action :set_gearbox_type, only: %i[ show edit update destroy ]

  # GET /gearbox_types or /gearbox_types.json
  def index
    @gearbox_types = GearboxType.all  
    render json: @gearbox_types
  end

  # GET /gearbox_types/1 or /gearbox_types/1.json
  def show  
    render json: @gearbox_type
  end

  # GET /gearbox_types/new
  def new
    @gearbox_type = GearboxType.new
  end

  # GET /gearbox_types/1/edit
  def edit  
    render json: @gearbox_type
  end

  # POST /gearbox_types or /gearbox_types.json
  def create
    @gearbox_type = GearboxType.new(gearbox_type_params)

    respond_to do |format|
      if @gearbox_type.save
    if @gearbox_type.save
      render json: @gearbox_type, status: :created
    else
      render json: @gearbox_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gearbox_types/1 or /gearbox_types/1.json
  def update  
    if @gearbox_type.update(gearbox_type_params)
      render json: @gearbox_type, status: :ok
    else
      render json: @gearbox_type.errors, status: :unprocessable_entity
    end
  end   

  # DELETE /gearbox_types/1 or /gearbox_types/1.json
  def destroy
    if @gearbox_type.destroy!
      render json: { message: 'Gearbox type was successfully destroyed.' }, status: :see_other    
    else
      render json: @gearbox_type.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gearbox_type
      @gearbox_type = GearboxType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gearbox_type_params
      params.require(:gearbox_type).permit(:name, :abbreviation)
    end
end
