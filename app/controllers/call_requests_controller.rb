class CallRequestsController < ApplicationController
  before_action :set_call_request, only: %i[ show edit update destroy ]

  # GET /call_requests or /call_requests.json
  def index
    @call_requests = CallRequest.all
  end

  # GET /call_requests/1 or /call_requests/1.json
  def show
  end

  # GET /call_requests/new
  def new
    @call_request = CallRequest.new
  end

  # GET /call_requests/1/edit
  def edit
  end

  # POST /call_requests or /call_requests.json
  def create
    @call_request = CallRequest.new(call_request_params)

    respond_to do |format|
      if @call_request.save
        format.html { redirect_to @call_request, notice: "Call request was successfully created." }
        format.json { render :show, status: :created, location: @call_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @call_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /call_requests/1 or /call_requests/1.json
  def update
    respond_to do |format|
      if @call_request.update(call_request_params)
        format.html { redirect_to @call_request, notice: "Call request was successfully updated." }
        format.json { render :show, status: :ok, location: @call_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @call_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /call_requests/1 or /call_requests/1.json
  def destroy
    @call_request.destroy!

    respond_to do |format|
      format.html { redirect_to call_requests_path, status: :see_other, notice: "Call request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_call_request
      @call_request = CallRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def call_request_params
      params.require(:call_request).permit(:car_id, :name, :phone, :preferred_time)
    end
end
