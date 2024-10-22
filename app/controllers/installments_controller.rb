class InstallmentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_installment, only: %i[ show edit update destroy ]

  # GET /installments or /installments.json
  def index
    @installments = Installment.all
    render json: @installments
  end

  # GET /installments/1 or /installments/1.json
  def show
  end

  # GET /installments/new
  def new
    @installment = Installment.new
  end

  # GET /installments/1/edit
  def edit
  end

  # POST /installments or /installments.json
  def create
    Rails.logger.info "Received params: #{params.inspect}"
    @installment = Installment.new(installment_params)

    if @installment.save  
      render json: @installment, status: :created
    else
      render json: @installment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /installments/1 or /installments/1.json
  def update
    if @installment.update(installment_params)
      render json: @installment, status: :ok
    else
      render json: @installment.errors, status: :unprocessable_entity
    end     
  end

  # DELETE /installments/1 or /installments/1.json
  def destroy
    @installment.destroy!
    render json: {}, status: :no_content      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_installment
      @installment = Installment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def installment_params
      params.require(:installment).permit(:car_id, :name, :phone, :credit_term, :initial_contribution)
    end
end
