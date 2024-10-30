class ExtraNamesController < ApplicationController
  before_action :set_extra_name, only: %i[ show edit update destroy ]

  # GET /extra_names or /extra_names.json
  def index
    @extra_names = ExtraName.all
    render json: @extra_names
  end

  # GET /extra_names/1 or /extra_names/1.json
  def show
    render json: @extra_name
  end

  # GET /extra_names/new
  def new
    @extra_name = ExtraName.new
  end

  # GET /extra_names/1/edit
  def edit
    render json: @extra_name
  end

  # POST /extra_names or /extra_names.json
  def create
    @extra_name = ExtraName.new(extra_name_params)

    if @extra_name.save
      render json: @extra_name, status: :created
    else
      render json: @extra_name.errors, status: :unprocessable_entity
    end
  end 


  # PATCH/PUT /extra_names/1 or /extra_names/1.json
  def update
    if @extra_name.update(extra_name_params)
      render json: @extra_name, status: :ok
    else
      render json: @extra_name.errors, status: :unprocessable_entity
    end
  end

  # DELETE /extra_names/1 or /extra_names/1.json
  def destroy
    @extra_name.destroy!
    render json: { message: 'Extra name was successfully destroyed.' }, status: :see_other    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extra_name
      @extra_name = ExtraName.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def extra_name_params
      params.require(:extra_name).permit(:name)
    end
end
