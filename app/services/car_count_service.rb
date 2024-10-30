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
                     .map do |car|
                       {
                         id: car.id,
                         year: car.year,
                         price: car.price,
                         description: car.description,
                         online_view_available: car.online_view_available,
                         brand: {
                           id: car.brand.id,
                           name: car.brand.name
                         },
                         model: {
                           id: car.model.id,
                           name: car.model.name
                         },
                         generation: {
                           id: car.generation.id,
                           name: car.generation.name,
                           start_date: car.generation.start_date,
                           end_date: car.generation.end_date,
                           modernization: car.generation.modernization
                         },
                         color: {
                           id: car.color.id,
                           name: car.color.name
                         },
                         body_type: {
                           id: car.body_type.id,
                           name: car.body_type.name
                         },
                         engine_type: {
                           id: car.engine_type.id,
                           name: car.engine_type.name,
                           engine_power: car.engine_type.engine_power,
                           engine_capacity: car.engine_type.engine_capacity
                         },
                         gearbox_type: {
                           id: car.gearbox_type.id,
                           name: car.gearbox_type.name,
                           abbreviation: car.gearbox_type.abbreviation
                         },
                         drive_type: {
                           id: car.drive_type.id,
                           name: car.drive_type.name
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