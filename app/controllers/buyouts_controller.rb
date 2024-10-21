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

    respond_to do |format|
      if @buyout.save
        format.html { redirect_to @buyout, notice: "Buyout was successfully created." }
        format.json { render :show, status: :created, location: @buyout }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @buyout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buyouts/1 or /buyouts/1.json
  def update
    respond_to do |format|
      if @buyout.update(buyout_params)
        format.html { redirect_to @buyout, notice: "Buyout was successfully updated." }
        format.json { render :show, status: :ok, location: @buyout }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @buyout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buyouts/1 or /buyouts/1.json
  def destroy
    @buyout.destroy!

    respond_to do |format|
      format.html { redirect_to buyouts_path, status: :see_other, notice: "Buyout was successfully destroyed." }
      format.json { head :no_content }
    end
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
