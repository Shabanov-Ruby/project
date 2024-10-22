class CarFilterService
  def initialize(params)
    @params = params
  end

  def call
    cars = Car.all

    cars = cars.by_brand_name(@params[:brand_name]) if @params[:brand_name].present?
    cars = cars.by_model_name(@params[:model_name]) if @params[:model_name].present?
    cars = cars.by_generation(@params[:generation_name]) if @params[:generation_name].present?

    cars = cars.by_year_from(@params[:year_from]) if @params[:year_from].present?
    cars = cars.by_price(@params[:max_price]) if @params[:max_price].present?
    cars = cars.by_engine_type(@params[:engine_type_id]) if @params[:engine_type_id].present?
    cars = cars.by_gearbox_type(@params[:gearbox_type_id]) if @params[:gearbox_type_id].present?
    cars = cars.by_body_type(@params[:body_type_id]) if @params[:body_type_id].present?
    cars = cars.by_drive_type(@params[:drive_type_id]) if @params[:drive_type_id].present?
    cars = cars.by_owners_count(@params[:owners_count]) if @params[:owners_count].present?

    cars
  end
end
