class GearboxTypesController < ApplicationController
  before_action :set_gearbox_type, only: %i[ show edit update destroy ]

  # GET /gearbox_types or /gearbox_types.json
  def index
    @gearbox_types = GearboxType.all
  end

  # GET /gearbox_types/1 or /gearbox_types/1.json
  def show
  end

  # GET /gearbox_types/new
  def new
    @gearbox_type = GearboxType.new
  end

  # GET /gearbox_types/1/edit
  def edit
  end

  # POST /gearbox_types or /gearbox_types.json
  def create
    @gearbox_type = GearboxType.new(gearbox_type_params)

    respond_to do |format|
      if @gearbox_type.save
        format.html { redirect_to @gearbox_type, notice: "Gearbox type was successfully created." }
        format.json { render :show, status: :created, location: @gearbox_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @gearbox_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gearbox_types/1 or /gearbox_types/1.json
  def update
    respond_to do |format|
      if @gearbox_type.update(gearbox_type_params)
        format.html { redirect_to @gearbox_type, notice: "Gearbox type was successfully updated." }
        format.json { render :show, status: :ok, location: @gearbox_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gearbox_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gearbox_types/1 or /gearbox_types/1.json
  def destroy
    @gearbox_type.destroy!

    respond_to do |format|
      format.html { redirect_to gearbox_types_path, status: :see_other, notice: "Gearbox type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gearbox_type
      @gearbox_type = GearboxType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gearbox_type_params
      params.require(:gearbox_type).permit(:name)
    end
end
