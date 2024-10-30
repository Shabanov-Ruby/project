class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    @categories = Category.all  
    render json: @categories
  end

  # GET /categories/1 or /categories/1.json
  def show
    render json: @category
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    render json: @category
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end   
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: @category.errors, status: :unprocessable_entity
    end 
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy!
    render json: { message: 'Category was successfully destroyed.' }, status: :see_other    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
