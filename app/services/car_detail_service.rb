class CarDetailService
  def self.call(brand_name, model_name, generation_name)
    cars = fetch_cars(brand_name, model_name, generation_name)
    cars.map { |car| format_car_details(car) }
  end

  private

  def self.fetch_cars(brand_name, model_name, generation_name)
    Car.joins(:brand, :model, :generation, :color, :body_type, :engine_type, :gearbox_type, :drive_type, :history_car)
       .includes(:images)
       .where('brands.name = ? AND models.name = ? AND generations.name = ?', brand_name, model_name, generation_name)
       .select(select_fields)
  end

  def self.select_fields
    'cars.id, cars.year, cars.price, cars.description, cars.online_view_available, 
     brands.id as brand_id, brands.name as brand_name, 
     models.id as model_id, models.name as model_name, 
     generations.id as generation_id, generations.name as generation_name, 
     generations.start_date, generations.end_date, generations.modernization, 
     colors.id as color_id, colors.name as color_name, 
     body_types.id as body_type_id, body_types.name as body_type_name, 
     engine_types.id as engine_type_id, engine_types.name as engine_type_name, 
     engine_types.engine_power, engine_types.engine_capacity, 
     gearbox_types.id as gearbox_type_id, gearbox_types.name as gearbox_type_name, 
     gearbox_types.abbreviation, 
     drive_types.id as drive_type_id, drive_types.name as drive_type_name,
     history_cars.vin, history_cars.registration_number, history_cars.last_mileage,
     history_cars.previous_owners'
  end

  def self.format_car_details(car)
    {
      id: car.id,
      year: car.year,
      price: car.price,
      description: car.description,
      online_view_available: car.online_view_available,
      brand: format_association(car, :brand),
      model: format_association(car, :model),
      generation: format_generation(car),
      color: format_association(car, :color),
      body_type: format_association(car, :body_type),
      engine_type: format_engine_type(car),
      gearbox_type: format_gearbox_type(car),
      drive_type: format_association(car, :drive_type),
      images: format_images(car),
      history: format_history(car)
    }
  end

  def self.format_history(car)
    {
      vin: car.vin,
      registration_number: car.registration_number,
      last_mileage: car.last_mileage,
      previous_owners: car.previous_owners,
    }
  end

  def self.format_association(car, association)
    {
      id: car.send("#{association}_id"),
      name: car.send("#{association}_name")
    }
  end

  def self.format_generation(car)
    {
      id: car.generation_id,
      name: car.generation_name,
      start_date: car.start_date,
      end_date: car.end_date,
      modernization: car.modernization
    }
  end

  def self.format_engine_type(car)
    {
      id: car.engine_type_id,
      name: car.engine_type_name,
      engine_power: car.engine_power,
      engine_capacity: car.engine_capacity
    }
  end

  def self.format_gearbox_type(car)
    {
      id: car.gearbox_type_id,
      name: car.gearbox_type_name,
      abbreviation: car.abbreviation
    }
  end

  def self.format_images(car)
    car.images.map do |image|
      {
        id: image.id,
        url: image.url
      }
    end
  end
end 