class OrdersCreditsController < ApplicationController
  before_action :set_orders_credit, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    @orders_credits = OrdersCredit.all
    render json: @orders_credits
  end

  def show
    render json: @orders_credit
  end

  def create
    @orders_credit = OrdersCredit.new(orders_credit_params)

    if @orders_credit.save
      render json: @orders_credit, status: :created
    else
      render json: @orders_credit.errors, status: :unprocessable_entity
    end
  end

  def update
    if @orders_credit.update(orders_credit_params)
      render json: @orders_credit, status: :ok
    else
      render json: @orders_credit.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @orders_credit.destroy
      head :ok
    else
      render json: @orders_credit.errors, status: :internal_server_error
    end
  end

  private
    def set_orders_credit
      @orders_credit = OrdersCredit.find(params[:id])
    end

    def orders_credit_params
      params.require(:orders_credit).permit(:credit_id, :order_status_id, :description)
    end
end
