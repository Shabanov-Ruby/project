class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show edit update destroy ]

  # GET /images or /images.json
  def index
    @images = Image.all
    render json: @images, each_serializer: ImageSerializer
  end

  # GET /images/1 or /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images or /images.json
  def create
    @image = Image.new(image_params)

    if @image.save
      render json: @image, status: :created
    else
      render json: @image.errors, status: :unprocessable_entity
    end   
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    if @image.update(image_params)
      render json: @image, status: :ok
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy!

    render json: { message: 'Image was successfully destroyed.' }, status: :see_other
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.require(:image).permit(:car_id, :url, :is_primary)
    end
end
