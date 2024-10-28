class CallRequestsController < ApplicationController
  #before_action :set_call_request, only: %i[ show edit update destroy ]
  protect_from_forgery with: :null_session

  # GET /call_requests or /call_requests.json
  def index
    @call_requests = CallRequest.all
    render json: @call_requests
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

    if @call_request.save
      render json: @call_request, status: :created
    else
      render json: @call_request.errors, status: :unprocessable_entity
    end 
  end 

  # PATCH/PUT /call_requests/1 or /call_requests/1.json
  def update
    if @call_request.update(call_request_params)
      render json: @call_request, status: :ok
    else
      render json: @call_request.errors, status: :unprocessable_entity
    end
  end   

  # DELETE /call_requests/1 or /call_requests/1.json
  def destroy
    @call_request.destroy!
    render json: { message: 'Call request was successfully destroyed.' }, status: :see_other
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
