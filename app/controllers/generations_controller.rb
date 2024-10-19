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
  end

  # POST /generations or /generations.json
  def create
    @generation = Generation.new(generation_params)

    respond_to do |format|
      if @generation.save
        format.html { redirect_to @generation, notice: "Generation was successfully created." }
        format.json { render :show, status: :created, location: @generation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @generation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /generations/1 or /generations/1.json
  def update
    respond_to do |format|
      if @generation.update(generation_params)
        format.html { redirect_to @generation, notice: "Generation was successfully updated." }
        format.json { render :show, status: :ok, location: @generation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @generation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /generations/1 or /generations/1.json
  def destroy
    @generation.destroy!

    respond_to do |format|
      format.html { redirect_to generations_path, status: :see_other, notice: "Generation was successfully destroyed." }
      format.json { head :no_content }
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
