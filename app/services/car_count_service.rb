class CarCountService
  def self.call
    brand_model_generation_counts = Car.joins(:brand, :model, :generation)
                                       .group('brands.name', 'models.name', 'generations.name')
                                       .count

    brand_counts = Car.joins(:brand)
                      .group('brands.name')
                      .count

    brand_counts.each_with_object({}) do |(brand_name, total_count), hash|
      hash[brand_name] = { total: total_count, models: {} }
    end.tap do |result|
      brand_model_generation_counts.each do |(brand_name, model_name, generation_name), count|
        result[brand_name][:models][model_name] ||= { total: 0, generations: {} }
        result[brand_name][:models][model_name][:total] += count
        result[brand_name][:models][model_name][:generations][generation_name] = count
      end
    end
  end
end 