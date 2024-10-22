class ExchangesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_exchange, only: %i[ show edit update destroy ]

  # GET /exchanges or /exchanges.json
  def index
    @exchanges = Exchange.all
    render json: @exchanges
  end

  # GET /exchanges/1 or /exchanges/1.json
  def show
  end

  # GET /exchanges/new
  def new
    @exchange = Exchange.new
  end

  # GET /exchanges/1/edit
  def edit
  end

  # POST /exchanges or /exchanges.json
  def create
    Rails.logger.info "Received params: #{params.inspect}"
    @exchange = Exchange.new(exchange_params)

    if @exchange.save
      render json: @exchange, status: :created
    else
      render json: @exchange.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exchanges/1 or /exchanges/1.json
  def update
    respond_to do |format|
      if @exchange.update(exchange_params)
        format.json { render :show, status: :ok, location: @exchange }
      else
        format.json { render json: @exchange.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exchanges/1 or /exchanges/1.json
  def destroy
    @exchange.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exchange
      @exchange = Exchange.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exchange_params
      params.require(:exchange).permit(:car_id, :customer_car, :name, :phone, :credit_term, :initial_contribution)
    end
end
