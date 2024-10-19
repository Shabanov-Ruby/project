class BodyTypesController < ApplicationController
  before_action :set_body_type, only: %i[ show edit update destroy ]

  # GET /body_types or /body_types.json
  def index
    @body_types = BodyType.all
  end

  # GET /body_types/1 or /body_types/1.json
  def show
  end

  # GET /body_types/new
  def new
    @body_type = BodyType.new
  end

  # GET /body_types/1/edit
  def edit
  end

  # POST /body_types or /body_types.json
  def create
    @body_type = BodyType.new(body_type_params)

    respond_to do |format|
      if @body_type.save
        format.html { redirect_to @body_type, notice: "Body type was successfully created." }
        format.json { render :show, status: :created, location: @body_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @body_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /body_types/1 or /body_types/1.json
  def update
    respond_to do |format|
      if @body_type.update(body_type_params)
        format.html { redirect_to @body_type, notice: "Body type was successfully updated." }
        format.json { render :show, status: :ok, location: @body_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @body_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /body_types/1 or /body_types/1.json
  def destroy
    @body_type.destroy!

    respond_to do |format|
      format.html { redirect_to body_types_path, status: :see_other, notice: "Body type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_body_type
      @body_type = BodyType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def body_type_params
      params.require(:body_type).permit(:name)
    end
end
