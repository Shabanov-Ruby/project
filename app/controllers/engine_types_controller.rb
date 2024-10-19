class EngineTypesController < ApplicationController
  before_action :set_engine_type, only: %i[ show edit update destroy ]

  # GET /engine_types or /engine_types.json
  def index
    @engine_types = EngineType.all
  end

  # GET /engine_types/1 or /engine_types/1.json
  def show
  end

  # GET /engine_types/new
  def new
    @engine_type = EngineType.new
  end

  # GET /engine_types/1/edit
  def edit
  end

  # POST /engine_types or /engine_types.json
  def create
    @engine_type = EngineType.new(engine_type_params)

    respond_to do |format|
      if @engine_type.save
        format.html { redirect_to @engine_type, notice: "Engine type was successfully created." }
        format.json { render :show, status: :created, location: @engine_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @engine_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /engine_types/1 or /engine_types/1.json
  def update
    respond_to do |format|
      if @engine_type.update(engine_type_params)
        format.html { redirect_to @engine_type, notice: "Engine type was successfully updated." }
        format.json { render :show, status: :ok, location: @engine_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @engine_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /engine_types/1 or /engine_types/1.json
  def destroy
    @engine_type.destroy!

    respond_to do |format|
      format.html { redirect_to engine_types_path, status: :see_other, notice: "Engine type was successfully destroyed." }
      format.json { head :no_content }
    end
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
