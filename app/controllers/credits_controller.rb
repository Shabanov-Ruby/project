class CreditsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_credit, only: %i[ show edit update destroy ]

  # GET /credits or /credits.json
  def index
    @credits = Credit.all
    render json: @credits
  end

  def top_programs
    @top_programs = TopProgramsService.call
    render json: @top_programs
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

    respond_to do |format|
      if @credit.save
        format.html { redirect_to @credit, notice: "Credit was successfully created." }
        format.json { render :show, status: :created, location: @credit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /credits/1 or /credits/1.json
  def update
    respond_to do |format|
      if @credit.update(credit_params)
        format.html { redirect_to @credit, notice: "Credit was successfully updated." }
        format.json { render :show, status: :ok, location: @credit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credits/1 or /credits/1.json
  def destroy
    @credit.destroy!

    respond_to do |format|
      format.html { redirect_to credits_path, status: :see_other, notice: "Credit was successfully destroyed." }
      format.json { head :no_content }
    end
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
