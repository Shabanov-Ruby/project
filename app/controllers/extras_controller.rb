class ExtrasController < ApplicationController
  before_action :set_extra, only: %i[ show edit update destroy ]

  # GET /extras or /extras.json
  def index
    @extras = Extra.all
    render json: @extras
  end

  # GET /extras/1 or /extras/1.json
  def show
    render json: @extra
  end

  # GET /extras/new
  def new
    @extra = Extra.new
  end

  # GET /extras/1/edit
  def edit
    render json: @extra
  end

  # POST /extras or /extras.json
  def create
    @extra = Extra.new(extra_params)

    if @extra.save
      render json: @extra, status: :created
    else
      render json: @extra.errors, status: :unprocessable_entity
    end
  end   

  # PATCH/PUT /extras/1 or /extras/1.json
  def update
    if @extra.update(extra_params)
      render json: @extra, status: :ok
    else
      render json: @extra.errors, status: :unprocessable_entity
    end
  end

  # DELETE /extras/1 or /extras/1.json
  def destroy
    if @extra.destroy!
      render json: { message: 'Extra was successfully destroyed.' }, status: :see_other   
    else
      render json: @extra.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extra
      @extra = Extra.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def extra_params
      params.require(:extra).permit(:car_id, :category_id, :name)
    end
end
