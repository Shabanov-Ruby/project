class ColorsController < ApplicationController
  before_action :set_color, only: %i[ show edit update destroy ]

  # GET /colors or /colors.json
  def index
    @colors = Color.all 
    render json: @colors
  end

  # GET /colors/1 or /colors/1.json
  def show
    render json: @color
  end

  # GET /colors/new
  def new
    @color = Color.new
  end

  # GET /colors/1/edit
  def edit
    render json: @color 
  end

  # POST /colors or /colors.json
  def create
    @color = Color.new(color_params)

    if @color.save  
      render json: @color, status: :created
    else
      render json: @color.errors, status: :unprocessable_entity
    end       
  end

  # PATCH/PUT /colors/1 or /colors/1.json
  def update
    if @color.update(color_params)
      render json: @color, status: :ok
    else
      render json: @color.errors, status: :unprocessable_entity
    end 
  end

  # DELETE /colors/1 or /colors/1.json
  def destroy
    @color.destroy!
    render json: { message: 'Color was successfully destroyed.' }, status: :see_other       
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color
      @color = Color.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def color_params
      params.require(:color).permit(:name, :hex_value)
    end
end
