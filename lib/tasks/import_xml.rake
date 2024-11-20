namespace :import do
  desc "Import cars and their history from XML"
  task cars: :environment do
    require 'nokogiri'
    require 'open-uri'

    #file_path = Rails.root.join('app', 'assets', 'xml', 'hpbz0dmc.xml')
    #xml_data = File.read(file_path)
    xml_data = URI.open('https://plex-crm.ru/xml/usecarmax/hpbz0dmc').read
    doc = Nokogiri::XML(xml_data)

    ActiveRecord::Base.transaction do
      doc.xpath('//car').each do |node|
        car = create_car_from_node(node)
        next unless car

        create_history_for_car(car, node)
        save_images_for_car(car, node)
        save_extras_for_car(car, node)
        puts "Car created: #{DateTime.now.strftime('%Y-%m-%d %H:%M:%S')}"
      end
    end
  end

  def create_car_from_node(node)
    brand = Brand.find_or_create_by(name: node.at_xpath('mark_id').text)
    model = Model.find_or_create_by(name: node.at_xpath('model_name').text, brand: brand)
    generation = find_or_create_generation(node, model)
    body_type = BodyType.find_or_create_by(name: node.at_xpath('body_type').text)
    color = Color.find_or_create_by(name: node.at_xpath('color').text)
    engine_name_type = EngineNameType.find_or_create_by(name: node.at_xpath('engine_type').text)
    engine_power_type = EnginePowerType.find_or_create_by(power: node.at_xpath('engine_power').text.to_i)
    engine_capacity_type = find_or_create_engine_capacity_type(node)
    gearbox_type = find_or_create_gearbox_type(node)
    drive_type = DriveType.find_or_create_by(name: node.at_xpath('drive')&.text || "Полный")

    car = Car.new(
      model: model,
      brand: brand,
      generation: generation,
      year: node.at_xpath('year').text.to_i,
      price: node.at_xpath('price').text.to_d,
      description: node.at_xpath('modification_id').text,
      color: color,
      body_type: body_type,
      engine_name_type: engine_name_type,
      engine_power_type: engine_power_type,
      engine_capacity_type: engine_capacity_type,
      gearbox_type: gearbox_type,
      drive_type: drive_type,
      online_view_available: true,
      complectation_name: node.at_xpath('complectation_name').text
    )

    if car.save
      puts "Car created for: #{car.brand.name} #{car.model.name} #{car.generation.name}"
      car
    else
      puts "Failed to create car for VIN: #{node.at_xpath('vin').text}"
      puts car.errors.full_messages.join(", ")
      nil
    end
  end

  def find_or_create_generation(node, model)
    generation = Generation.find_or_initialize_by(name: node.at_xpath('generation_name').text, model: model)
    generation.save unless generation.persisted?
    generation
  end

  def find_or_create_engine_capacity_type(node)
    modification_text = node.at_xpath('modification_id').text
    engine_capacity_match = modification_text.match(/(\d+\.\d+)/)
    engine_capacity = engine_capacity_match[1] if engine_capacity_match

    EngineCapacityType.find_or_create_by(
      capacity: engine_capacity.to_f 
    )
  end

  def find_or_create_gearbox_type(node)
    gearbox_name = node.at_xpath('gearbox').text
    abbreviations = {
      'Автоматическая' => 'АКПП',
      'Механическая' => 'МКПП',
      'Автомат вариатор' => 'CVT',
      'Автомат робот' => 'РКПП'
    }
    abbreviation = abbreviations[gearbox_name]

    GearboxType.find_or_create_by(name: gearbox_name) do |gt|
      gt.abbreviation = abbreviation
    end.tap do |gearbox_type|
      gearbox_type.update(abbreviation: abbreviation) if gearbox_type.abbreviation.blank?
    end
  end

  def create_history_for_car(car, node)
    vin = node.at_xpath('vin').text
    original_vin = vin # Сохраняем оригинальный VIN для дальнейшего использования
  
    # Проверяем, существует ли VIN в базе данных
    while HistoryCar.exists?(vin: vin)
      # Генерируем две случайные буквы или цифры
      random_suffix = Array.new(2) { rand(0..9).to_s + ('A'..'Z').to_a.sample }.join
      vin = "#{original_vin}#{random_suffix}" # Добавляем к оригинальному VIN
    end
  
    owners_number_text = node.at_xpath('owners_number').text.downcase.split.first
    text_to_number = {
      "ноль" => 0, "один" => 1, "два" => 2, "три" => 3, "четыре" => 4,
      "пять" => 5, "шесть" => 6, "семь" => 7, "восемь" => 8, "девять" => 9, "десять" => 10
    }
    owners_number = text_to_number[owners_number_text] || owners_number_text.scan(/\d+/).first.to_i
  
    # Получаем текстовое значение элемента 'run'
    run_value = node.at_xpath('run')&.text

    # Проверяем, является ли значение числом, и устанавливаем params_last_mileage
    params_last_mileage = (run_value && run_value.match?(/^\d+$/)) ? run_value.to_i : 10
  
    history_car = HistoryCar.create(
      car: car,
      vin: vin,
      last_mileage: params_last_mileage,
      previous_owners: owners_number,
      registration_number: "Отсутствует",
      registration_restrictions: "Не найдены ограничения на регистрацию",
      registration_restrictions_info: "Запрет регистрационных действий на машину накладывается, если у автовладельца есть неоплаченные штрафы и налоги, либо если имущество стало предметом спора.",
      wanted_status: "Нет сведений о розыске",
      wanted_status_info: "Покупка разыскиваемого автомобиля грозит тем, что его отберут в ГИБДД при регистрации, и пока будет идти следствие, а это может затянуться на долгий срок, автомобиль будет стоять на штрафплощадке.",
      pledge_status: "Залог не найден",
      pledge_status_info: "Мы проверили базы данных Федеральной нотариальной палаты (ФНП) и Национального бюро кредитных историй (НБКИ).",
      accidents_found: "ДТП не найдены",
      accidents_found_info: "В отчёт не попадут аварии, которые произошли раньше 2015 года или не оформлялись в ГИБДД.",
      repair_estimates_found: "Не найдены расчёты стоимости ремонта",
      repair_estimates_found_info: "Мы проверяем, во сколько эксперты страховых компаний оценили восстановление автомобиля после ДТП. Расчёт не означает, что машину ремонтировали.",
      taxi_usage: "Не найдено разрешение на работу в такси",
      taxi_usage_info: "Данные представлены из региональных баз по регистрации автомобиля в качестве такси.",
      carsharing_usage: "Не найдены сведения об использовании в каршеринге",
      carsharing_usage_info: "На каршеринговых авто ездят практически круглосуточно. Они много времени проводят в пробках — от этого двигатель и сцепление быстро изнашиваются. Салон тоже страдает от большого количества водителей и пассажиров.",
      diagnostics_found: "Не найдены сведения о диагностике",
      diagnostics_found_info: "В блоке представлены данные по оценке состояния автомобиля по результатам офлайн диагностики. В ходе диагностики специалисты проверяют состояние ЛКП, всех конструкций автомобиля, состояние салона, фактическую комплектацию и проводят небольшой тест-драйв.",
      technical_inspection_found: "Не найдены сведения о техосмотрах",
      technical_inspection_found_info: "В данном блоке отображаются данные о прохождении техосмотра на основании данных диагностических карт ТС. Срок прохождения технического осмотра для автомобилей категории «B»: — первые четыре года — не требуется; — возраст от 4 до 10 лет — каждые 2 года; — старше 10 лет — ежегодно.",
      imported: "Нет сведений о ввозе из-за границы",
      imported_info: "Данные из таможенной декларации, которую заполняет компания, осуществляющая ввоз транспортного средства на территорию РФ.",
      insurance_found: "Нет полиса ОСАГО",
      recall_campaigns_found: "Не найдены сведения об отзывных кампаниях",
      recall_campaigns_found_info: "Для данного автомобиля не проводилось или нет действующих отзывных кампаний. Отзыв автомобиля представляет собой устранение выявленного брака. Практически все автомобильные производители периодически отзывают свои продукты для устранения дефектов."
    )
  
    if history_car.save
      puts "History saved for car: #{car.id}"
    else
      puts "History not created for car VIN: #{vin}"
      puts "Errors: #{history_car.errors.full_messages.join(", ")}"
    end
  end

  def save_images_for_car(car, node)
    node.xpath('images/image').each do |image_node|
      Image.create(car: car, url: image_node.text)
    end
    puts "Images saved for car: #{car.id}"
  end

  def save_extras_for_car(car, node)
    extras_string = node.at_xpath('extras').text
    extras_array = extras_string.split(',').map(&:strip)

    extras_array.each do |extra|
      category_name = case extra
                      when /фары|датчик/
                        'Обзор'
                      when /диски|рейлинги/
                        'Элементы экстерьера'
                      when /иммобилайзер|замок|сигнализация/
                        'Защита от угона'
                      when /audi|usb|bluetooth|навигационная система|розетка/
                        'Мультимедиа'
                      when /салон|обогрев|подогрев|подголовник|регулировка|подлокотник/
                        'Салон'
                      when /камера|климат|компьютер|мультифункциональное|складывание|доступ|парктроник|круиз|усилитель|привод|стеклоподъемники|прикуриватель/
                        'Комфорт'
                      when /система|подушка/
                        'Безопасность'
                      else
                        'Прочее'
                      end

      category = Category.find_or_create_by(name: category_name)
      extra_name = ExtraName.find_or_create_by(name: extra)
      Extra.create(car: car, category: category, extra_name: extra_name)
    end
    puts "Extras saved for car: #{car.id}"
  end
end
