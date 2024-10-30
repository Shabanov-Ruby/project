class GenerationsController < ApplicationController
  before_action :set_generation, only: [:show, :update, :destroy]

  # GET /generations or /generations.json
  def index
    @generations = Generation.all
    render json: @generations
  end

  # GET /generations/1 or /generations/1.json
  def show
    render json: @generation
  end

  # GET /generations/new
  def new
    @generation = Generation.new
  end

  # GET /generations/1/edit
  def edit  
    render json: @generation
  end

  # POST /generations or /generations.json
  def create
    @generation = Generation.new(generation_params)

    if @generation.save 
      render json: @generation, status: :created
    else
      render json: @generation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /generations/1 or /generations/1.json
  def update
    if @generation.update(generation_params)
      render json: @generation, status: :ok
    else
      render json: @generation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /generations/1 or /generations/1.json
  def destroy
    if @generation.destroy!
      render json: { message: "Generation was successfully destroyed." }, status: :see_other
    else
      render json: @generation.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_generation
      @generation = Generation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def generation_params
      params.require(:generation).permit(:name, :start_date, :end_date, :model_id)
    end
end
