class ModelsController < ApplicationController
  before_action :set_model, only: [:show, :update, :destroy]
  
  # GET /models or /models.json
  def index
    @models = Model.all
    render json: @models, include: ['brand']
  end

  # GET /models/1 or /models/1.json
  def show
    render json: @model
  end

  # GET /models/new
  def new
    @model = Model.new
  end

  # GET /models/1/edit
  def edit  
    render json: @model
  end

  # POST /models or /models.json
  def create
    @model = Model.new(model_params)
    if @model.save
      render json: @model, status: :created
    else
      render json: @model.errors, status: :unprocessable_entity
    end   
  end

  # PATCH/PUT /models/1 or /models/1.json
  def update
    if @model.update(model_params)
      render json: @model, status: :ok
    else
      render json: @model.errors, status: :unprocessable_entity
    end           
  end

  # DELETE /models/1 or /models/1.json
  def destroy
    if @model.destroy!
      render json: { message: "Model was successfully destroyed." }, status: :see_other    
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  private
    def set_brand
      @brand = Brand.find_by(name: params[:brand_name])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @model = Model.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def model_params
      params.require(:model).permit(:name, :brand_id)
    end
end
