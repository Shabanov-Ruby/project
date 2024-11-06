class BrandsController < ApplicationController
  before_action :set_brand, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /brands
  def index
    @brands = Brand.all
    render json: @brands
  end

  # GET /brands/1
  def show
    render json: @brand, serializer: BrandSerializer
  end

  # POST /brands
  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      render json: @brand, status: :created, location: @brand
    else
      render json: @brand.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /brands/1
  def update
    if @brand.update(brand_params)
      render json: @brand
    else
      render json: @brand.errors, status: :unprocessable_entity
    end
  end

  # DELETE /brands/1
  def destroy
    @brand.destroy
    head :no_content
  end

  private

  def set_brand
    if params[:id].present?
      @brand = Brand.find_by(id: params[:id])
      if @brand.nil?
        render json: { error: 'Бренд не найден' }, status: :not_found
      end
    else
      render json: { error: 'Не указан ID бренда' }, status: :bad_request
    end
  end

  def brand_params
    params.require(:brand).permit(:name)
  end
end
