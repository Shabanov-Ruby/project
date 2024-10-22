class BuyoutsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_buyout, only: %i[ show edit update destroy ]

  # GET /buyouts or /buyouts.json
  def index
    @buyouts = Buyout.all
    render json: @buyouts
  end

  # GET /buyouts/1 or /buyouts/1.json
  def show
  end

  # GET /buyouts/1/edit
  def edit
  end

  # POST /buyouts or /buyouts.json
  def create
    Rails.logger.info "Received params: #{params.inspect}"
    @buyout = Buyout.new(buyout_params)

    if @buyout.save
      render json: @buyout, status: :created
    else
      render json: @buyout.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /buyouts/1 or /buyouts/1.json
  def update
    if @buyout.update(buyout_params)
      render json: @buyout, status: :ok
    else
      render json: @buyout.errors, status: :unprocessable_entity
    end
  end

  # DELETE /buyouts/1 or /buyouts/1.json
  def destroy
    @buyout.destroy!

    render json: {}, status: :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buyout
      @buyout = Buyout.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def buyout_params
      params.require(:buyout).permit(:name, :phone, :brand, :model, :year, :mileage)
    end
end
