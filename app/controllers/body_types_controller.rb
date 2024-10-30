class BodyTypesController < ApplicationController
  before_action :set_body_type, only: %i[ show edit update destroy ]

  # GET /body_types or /body_types.json
  def index
    @body_types = BodyType.all
    render json: @body_types
  end

  # GET /body_types/1 or /body_types/1.json
  def show
    render json: @body_type
  end

  # GET /body_types/new
  def new
    @body_type = BodyType.new
    render json: @body_type
  end

  # GET /body_types/1/edit
  def edit
    render json: @body_type
  end

  # POST /body_types or /body_types.json
  def create
    @body_type = BodyType.new(body_type_params)
    if @body_type.save
      render json: @body_type, status: :created
    else
      render json: @body_type.errors, status: :unprocessable_entity
    end     
  end

  # PATCH/PUT /body_types/1 or /body_types/1.json
  def update
    if @body_type.update(body_type_params)
      render json: @body_type, status: :ok
    else
      render json: @body_type.errors, status: :unprocessable_entity
    end
  end     

  # DELETE /body_types/1 or /body_types/1.json
  def destroy
    @body_type.destroy!
    render json: { message: 'Body type was successfully destroyed.' }, status: :see_other  
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
