class ExtraNamesController < ApplicationController
  before_action :set_extra_name, only: %i[ show edit update destroy ]

  # GET /extra_names or /extra_names.json
  def index
    @extra_names = ExtraName.all
  end

  # GET /extra_names/1 or /extra_names/1.json
  def show
  end

  # GET /extra_names/new
  def new
    @extra_name = ExtraName.new
  end

  # GET /extra_names/1/edit
  def edit
  end

  # POST /extra_names or /extra_names.json
  def create
    @extra_name = ExtraName.new(extra_name_params)

    respond_to do |format|
      if @extra_name.save
        format.html { redirect_to @extra_name, notice: "Extra name was successfully created." }
        format.json { render :show, status: :created, location: @extra_name }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @extra_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extra_names/1 or /extra_names/1.json
  def update
    respond_to do |format|
      if @extra_name.update(extra_name_params)
        format.html { redirect_to @extra_name, notice: "Extra name was successfully updated." }
        format.json { render :show, status: :ok, location: @extra_name }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @extra_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extra_names/1 or /extra_names/1.json
  def destroy
    @extra_name.destroy!

    respond_to do |format|
      format.html { redirect_to extra_names_path, status: :see_other, notice: "Extra name was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extra_name
      @extra_name = ExtraName.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def extra_name_params
      params.require(:extra_name).permit(:name)
    end
end
