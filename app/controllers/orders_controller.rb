class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    @orders = Order.all
    render json: @orders
  end

  def show
    render json: @order
  end 

  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: @order, status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @order.destroy!
      head :ok  
    else
      render json: @order.errors, status: :internal_server_error
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Заказ не найден." }, status: :not_found
    end

    def order_params
      params.require(:order).permit(:buyout_id, :credit_id, :exchange_id, :installment_id, :call_request_id, :order_status_id, :description)
    end
end
