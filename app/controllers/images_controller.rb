class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    per_page = 18
    @images = Image.page(params[:page]).per(per_page)
    render json: @images
  end

  def show
    render json: @image
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      render json: @image, status: :created
    else
      render json: @image.errors, status: :unprocessable_entity
    end   
  end

  def update
    if @image.update(image_params)
      render json: @image, status: :ok
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @image.destroy
      head :ok
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  private
    def set_image
      @image = Image.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Изображение не найдено' }, status: :not_found
    end

    def image_params
      params.require(:image).permit(:car_id, :url)
    end
end
