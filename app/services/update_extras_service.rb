class UpdateExtrasService
  def initialize(extras_params)
    @extras_params = extras_params
  end

  def call
    @extras_params.each do |extra_params|
      if extra_params[:id].present?
        # Обновление существующей записи
        extra = Extra.find_by(id: extra_params[:id])
        extra.update(
          car_id: extra_params[:car_id],
          category_id: extra_params[:category_id],
          name: extra_params[:name]
        ) if extra
      else
        # Создание новой записи
        Extra.create(
          car_id: extra_params[:car_id],
          category_id: extra_params[:category_id],
          name: extra_params[:name]
        )
      end
    end
  end
end 