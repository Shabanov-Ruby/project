class DriveTypesController < ApplicationController
  before_action :set_drive_type, only: %i[ show edit update destroy ]

  # GET /drive_types or /drive_types.json
  def index
    @drive_types = DriveType.all 
    render json: @drive_types
  end

  # GET /drive_types/1 or /drive_types/1.json
  def show
    render json: @drive_type
  end

  # GET /drive_types/new
  def new
    @drive_type = DriveType.new
  end

  # GET /drive_types/1/edit
  def edit
    render json: @drive_type
  end

  # POST /drive_types or /drive_types.json
  def create
    @drive_type = DriveType.new(drive_type_params)

    if @drive_type.save
      render json: @drive_type, status: :created
    else
      render json: @drive_type.errors, status: :unprocessable_entity
    end
  end     

  # PATCH/PUT /drive_types/1 or /drive_types/1.json
  def update
    if @drive_type.update(drive_type_params)
      render json: @drive_type, status: :ok
    else
      render json: @drive_type.errors, status: :unprocessable_entity
    end
  end   

  # DELETE /drive_types/1 or /drive_types/1.json
  def destroy
    @drive_type.destroy!  
    render json: { message: 'Drive type was successfully destroyed.' }, status: :see_other    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drive_type
      @drive_type = DriveType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def drive_type_params
      params.require(:drive_type).permit(:name)
    end
end
