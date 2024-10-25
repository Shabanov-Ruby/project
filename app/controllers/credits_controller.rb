class CreditsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_credit, only: %i[ show edit update destroy ]

  # GET /credits or /credits.json
  def index
    @credits = Credit.all
    render json: @credits
  end

  def top_programs
    @all_banks = Bank.includes(:programs).all
    render json: @all_banks.to_json(include: :programs)
  end

  # GET /credits/1 or /credits/1.json
  def show
    @credit = Credit.find(params[:id])
    render json: @credit  
  end


  # GET /credits/1/edit
  def edit
  end

  # POST /credits or /credits.json
  def create
    Rails.logger.info "Received params: #{params.inspect}"
    @credit = Credit.new(credit_params)

    if @credit.save 
      render json: @credit, status: :created
    else
      render json: @credit.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /credits/1 or /credits/1.json
  def update
    if @credit.update(credit_params)
      render json: @credit, status: :ok
    else
      render json: @credit.errors, status: :unprocessable_entity
    end
  end

  # DELETE /credits/1 or /credits/1.json
  def destroy
    @credit.destroy!
    render json: {}, status: :no_content    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit
      @credit = Credit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def credit_params
      params.require(:credit).permit(:car_id, :name, :phone, :credit_term, :initial_contribution, :banks_id, :programs_id)
    end
end
