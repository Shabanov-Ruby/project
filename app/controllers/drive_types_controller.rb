class DriveTypesController < ApplicationController
  before_action :set_drive_type, only: %i[ show edit update destroy ]

  # GET /drive_types or /drive_types.json
  def index
    @drive_types = DriveType.all
  end

  # GET /drive_types/1 or /drive_types/1.json
  def show
  end

  # GET /drive_types/new
  def new
    @drive_type = DriveType.new
  end

  # GET /drive_types/1/edit
  def edit
  end

  # POST /drive_types or /drive_types.json
  def create
    @drive_type = DriveType.new(drive_type_params)

    respond_to do |format|
      if @drive_type.save
        format.html { redirect_to @drive_type, notice: "Drive type was successfully created." }
        format.json { render :show, status: :created, location: @drive_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @drive_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drive_types/1 or /drive_types/1.json
  def update
    respond_to do |format|
      if @drive_type.update(drive_type_params)
        format.html { redirect_to @drive_type, notice: "Drive type was successfully updated." }
        format.json { render :show, status: :ok, location: @drive_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @drive_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drive_types/1 or /drive_types/1.json
  def destroy
    @drive_type.destroy!

    respond_to do |format|
      format.html { redirect_to drive_types_path, status: :see_other, notice: "Drive type was successfully destroyed." }
      format.json { head :no_content }
    end
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
