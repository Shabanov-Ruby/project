class ProgramsController < ApplicationController
  before_action :set_program, only: %i[ show edit update destroy ]

  # GET /programs or /programs.json
  def index
    @programs = Program.all
    render json: @programs
  end

  # GET /programs/1 or /programs/1.json
  def show
    render json: @program
  end

  # GET /programs/new
  def new
    @program = Program.new
  end

  # GET /programs/1/edit
  def edit
    render json: @program
  end

  # POST /programs or /programs.json
  def create
    @program = Program.new(program_params)
    if @program.save
      render json: @program, status: :created
    else
      render json: @program.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /programs/1 or /programs/1.json
  def update
    if @program.update(program_params)
      render json: @program, status: :ok
    else
      render json: @program.errors, status: :unprocessable_entity
    end
  end

  # DELETE /programs/1 or /programs/1.json
  def destroy
    if @program.destroy!
      render json: { message: "Program was successfully destroyed." }, status: :see_other    
    else
      render json: @program.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def program_params
      params.require(:program).permit(:bank_id, :program_name, :interest_rate, :max_term, :max_amount, :created_at)
    end
end
