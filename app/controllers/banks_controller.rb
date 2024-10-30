class BanksController < ApplicationController
  before_action :set_bank, only: %i[ show edit update destroy ]

  # GET /banks or /banks.json
  def index
    @banks = Bank.includes(:programs).all
    render json: @banks.as_json(include: :programs)
  end

  # GET /banks/1 or /banks/1.json
  def show
  end

  # GET /banks/new
  def new
    @bank = Bank.new
  end

  # GET /banks/1/edit
  def edit
  end

  # POST /banks or /banks.json
  def create
    @bank = Bank.new(bank_params)
    if @bank.save 
      render json: @bank, status: :created
    else
      render json: @bank.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /banks/1 or /banks/1.json
  def update
    if @bank.update(bank_params)
      render json: @bank, status: :ok
    else
      render json: @bank.errors, status: :unprocessable_entity
    end
  end

  # DELETE /banks/1 or /banks/1.json
  def destroy
    @bank.destroy!
    render json: { message: 'Bank was successfully destroyed.' }, status: :see_other  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank
      @bank = Bank.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_params
      params.require(:bank).permit(:name, :country, :created_at)
    end
end
