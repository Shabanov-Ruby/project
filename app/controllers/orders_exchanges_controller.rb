class OrdersExchangesController < ApplicationController
  before_action :set_orders_exchange, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    @orders_exchanges = OrdersExchange.all
    render json: @orders_exchanges
  end

  def show
    render json: @orders_exchange
  end

  def create
    @orders_exchange = OrdersExchange.new(orders_exchange_params)

    if @orders_exchange.save
      render json: @orders_exchange, status: :created
    else
      render json: @orders_exchange.errors, status: :unprocessable_entity
    end 
  end

  def update
    if @orders_exchange.update(orders_exchange_params)
        render json: @orders_exchange, status: :ok
    else
      render json: @orders_exchange.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @orders_exchange.destroy
      head :ok
    else
      render json: @orders_exchange.errors, status: :unprocessable_entity
    end
  end

  private
    def set_orders_exchange
      @orders_exchange = OrdersExchange.find(params[:id])
    end

    def orders_exchange_params
      params.require(:orders_exchange).permit(:exchanges_id, :order_status_id, :description)
    end
end
