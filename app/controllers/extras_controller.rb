class ExtrasController < ApplicationController
  before_action :set_extra, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    per_page = 18
    @extras = Extra.page(params[:page]).per(per_page)
    render json: @extras
  end

  def show
    render json: @extra
  end

  def create
    @extra = Extra.new(extra_params)

    if @extra.save
      render json: @extra, status: :created
    else
      render json: @extra.errors, status: :unprocessable_entity
    end
  end   

  def update
    if @extra.update(extra_params)
      render json: @extra, status: :ok
    else
      render json: @extra.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @extra.destroy
      head :ok  
    else
      render json: @extra.errors, status: :unprocessable_entity
    end
  end

  private
    def set_extra
      @extra = Extra.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Дополнительное оборудование не найдено." }, status: :not_found
    end

    def extra_params
      params.require(:extra).permit(:car_id, :category_id, :extra_name_id)
    end
end
