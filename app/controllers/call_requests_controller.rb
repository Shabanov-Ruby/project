class CallRequestsController < ApplicationController
  before_action :set_call_request, only: %i[ show update destroy ]
  protect_from_forgery with: :null_session

  def index
    @call_requests = CallRequest.all
    render json: @call_requests
  end

  def show
    render json: @call_request
  end


  def create
    @call_request = CallRequest.new(call_request_params)

    if @call_request.save
      render json: @call_request, status: :created
    else
      render json: @call_request.errors, status: :unprocessable_entity
    end 
  end 

  def update
    if @call_request.update(call_request_params)
      render json: @call_request, status: :ok
    else
      render json: @call_request.errors, status: :unprocessable_entity
    end
  end   

  def destroy
    @call_request.destroy
    head :ok
  end

  private
    def set_call_request
      @call_request = CallRequest.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Заявка не найдена' }, status: :not_found
    end

    def call_request_params
      params.require(:call_request).permit(:car_id, :name, :phone, :preferred_time)
    end
end
