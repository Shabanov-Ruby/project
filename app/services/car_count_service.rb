class CarCountService
  def self.call
    brand_model_generation_counts = Car.joins(:brand, :model, :generation)
                                       .group('brands.name', 'models.name', 'generations.name')
                                       .count

    brand_counts = Car.joins(:brand)
                      .group('brands.name')
                      .count

    brand_counts.map do |brand_name, total_count|
      {
        brand: brand_name,
        total: total_count,
        models: brand_model_generation_counts.each_with_object({}) do |((b_name, model_name, generation_name), count), models_hash|
          next unless b_name == brand_name

          models_hash[model_name] ||= { total: 0, generations: {} }
          models_hash[model_name][:total] += count
          models_hash[model_name][:generations][generation_name] = {
            count: count,
            cars: Car.joins(:brand, :model, :generation, :color, :body_type, :engine_type, :gearbox_type, :drive_type)
                     .includes(:images)
                     .where('brands.name = ? AND models.name = ? AND generations.name = ?', brand_name, model_name, generation_name)
                     .select('cars.id, cars.year, cars.price, cars.description, cars.online_view_available, 
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
                              drive_types.id as drive_type_id, drive_types.name as drive_type_name')
                     .map do |car|
                       {
                         id: car.id,
                         year: car.year,
                         price: car.price,
                         description: car.description,
                         online_view_available: car.online_view_available,
                         brand: {
                           id: car.brand_id,
                           name: car.brand_name
                         },
                         model: {
                           id: car.model_id,
                           name: car.model_name
                         },
                         generation: {
                           id: car.generation_id,
                           name: car.generation_name,
                           start_date: car.start_date,
                           end_date: car.end_date,
                           modernization: car.modernization
                         },
                         color: {
                           id: car.color_id,
                           name: car.color_name
                         },
                         body_type: {
                           id: car.body_type_id,
                           name: car.body_type_name
                         },
                         engine_type: {
                           id: car.engine_type_id,
                           name: car.engine_type_name,
                           engine_power: car.engine_power,
                           engine_capacity: car.engine_capacity
                         },
                         gearbox_type: {
                           id: car.gearbox_type_id,
                           name: car.gearbox_type_name,
                           abbreviation: car.abbreviation
                         },
                         drive_type: {
                           id: car.drive_type_id,
                           name: car.drive_type_name
                         },
                         images: car.images.map do |image|
                           {
                             id: image.id,
                             url: image.url
                           }
                         end
                       }
                     end
          }
        end.values
      }
    end
  end
end 