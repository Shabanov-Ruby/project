class CarFilterDataService
  def self.call(filters = {})
    cars = Car.all
    cars = apply_filters(cars, filters)
    all_brands = Car.joins(:brand).distinct.pluck('brands.name')

    # Получаем модели для выбранного бренда, если он выбран
    selected_brand_models = filters[:brand_name].present? ? Model.joins(:brand).where('brands.name = ?', filters[:brand_name]).distinct.pluck('models.name') : []
    selected_model_generations = filters[:model_name].present? ? Generation.joins(:model).where('models.name = ?', filters[:model_name]).distinct.pluck('generations.name') : []

    # Получаем количество машин после применения фильтров
    car_count = cars.count

    [
      { key: :brands, values: all_brands },
      { key: :models, values: selected_brand_models.empty? ? ['Все модели'] : selected_brand_models },
      { key: :generations, values: selected_model_generations.empty? ? ['Поколения'] : selected_model_generations },
      { key: :years, values: cars.distinct.pluck(:year).sort },
      { key: :prices, values: fetch_price_ranges(cars) },
      { key: :engines, values: cars.joins(:engine_type).distinct.pluck('engine_types.name') },
      { key: :gearboxes, values: cars.joins(:gearbox_type).distinct.pluck('gearbox_types.name') },
      { key: :body_types, values: cars.joins(:body_type).distinct.pluck('body_types.name') },
      { key: :drives, values: cars.joins(:drive_type).distinct.pluck('drive_types.name') },
      { key: :previous_owners, values: cars.joins(:history_cars).distinct.pluck('history_cars.previous_owners').sort },
      { key: :car_count, value: car_count }
    ]
  end

  private

  def self.apply_filters(cars, filters)
    cars = cars.by_brand_name(filters[:brand_name]) if filters[:brand_name].present?
    cars = cars.by_model_name(filters[:model_name]) if filters[:model_name].present?
    cars = cars.by_generation(filters[:generation_name]) if filters[:generation_name].present?
    cars = cars.by_year_from(filters[:year_from]) if filters[:year_from].present?
    cars = cars.by_price(filters[:max_price]) if filters[:max_price].present?
    cars = cars.by_gearbox_type(filters[:gearbox_type_id]) if filters[:gearbox_type_id].present?
    cars = cars.by_body_type(filters[:body_type_id]) if filters[:body_type_id].present?
    cars = cars.by_drive_type(filters[:drive_type_id]) if filters[:drive_type_id].present?
    cars = cars.by_owners_count(filters[:owners_count]) if filters[:owners_count].present?
    cars = cars.by_engine_type_name(filters[:engine_type_name]) if filters[:engine_type_name].present?
    cars
  end

  def self.fetch_price_ranges(cars)
    min_price = 300_000
    max_price = cars.maximum(:price).ceil(-5)
    (min_price..max_price).step(100_000).to_a
  end
end 