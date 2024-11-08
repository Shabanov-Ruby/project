class InstallmentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_installment, only: %i[ show update destroy ]

  def index
    @installments = Installment.all
    render json: @installments
  end

  def show  
    render json: @installment
  end

  def create
    Rails.logger.info "Received params: #{params.inspect}"
    @installment = Installment.new(installment_params)

    if @installment.save  
      render json: @installment, status: :created
    else
      render json: @installment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @installment.update(installment_params)
      render json: @installment, status: :ok
    else
      render json: @installment.errors, status: :unprocessable_entity
    end     
  end

  def destroy
    if @installment.destroy
      head :ok
    else
      render json: @installment.errors, status: :unprocessable_entity
    end
  end

  private
    def set_installment
      @installment = Installment.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Рассрочка не найдена" }, status: :not_found
    end

    def installment_params
      params.require(:installment).permit(:car_id, :name, :phone, :credit_term, :initial_contribution)
    end
end
