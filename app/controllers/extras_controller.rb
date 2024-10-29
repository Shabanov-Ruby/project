class ExtrasController < ApplicationController
  before_action :set_extra, only: %i[ show edit update destroy ]

  # GET /extras or /extras.json
  def index
    @extras = Extra.all
  end

  # GET /extras/1 or /extras/1.json
  def show
  end

  # GET /extras/new
  def new
    @extra = Extra.new
  end

  # GET /extras/1/edit
  def edit
  end

  # POST /extras or /extras.json
  def create
    @extra = Extra.new(extra_params)

    respond_to do |format|
      if @extra.save
        format.html { redirect_to @extra, notice: "Extra was successfully created." }
        format.json { render :show, status: :created, location: @extra }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @extra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extras/1 or /extras/1.json
  def update
    respond_to do |format|
      if @extra.update(extra_params)
        format.html { redirect_to @extra, notice: "Extra was successfully updated." }
        format.json { render :show, status: :ok, location: @extra }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @extra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extras/1 or /extras/1.json
  def destroy
    @extra.destroy!

    respond_to do |format|
      format.html { redirect_to extras_path, status: :see_other, notice: "Extra was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extra
      @extra = Extra.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def extra_params
      params.require(:extra).permit(:car_id, :category_id, :name)
    end
end
