namespace :import do
  desc "Import cars and their history from XML"
  task cars: :environment do
    require 'nokogiri'
    require 'open-uri'

    url = 'https://plex-crm.ru/xml/youauto/hpbz0dmc'
    xml_data = URI.open(url).read
    doc = Nokogiri::XML(xml_data)

    doc.xpath('//car').each do |node|
      # Извлечение данных из XML
      mark_name = node.at_xpath('mark_id').text
      model_name = node.at_xpath('model_name').text
      generation_name = node.at_xpath('generation_name').text
      modification_text = node.at_xpath('modification_id').text

      # Найдите или создайте связанные записи
      brand = Brand.find_or_create_by(name: mark_name)
      model = Model.find_or_create_by(name: model_name, brand: brand)
      generation = Generation.find_or_initialize_by(name: generation_name, model: model)
      unless generation.persisted?
        generation.save
      end

      body_type = BodyType.find_or_create_by(name: node.at_xpath('body_type').text)
      color = Color.find_or_create_by(name: node.at_xpath('color').text)

      engine_capacity_match = modification_text.match(/(\d+\.\d+)/)
      engine_capacity = engine_capacity_match[1] if engine_capacity_match


      engine_type = EngineType.find_or_create_by(name: node.at_xpath('engine_type').text, 
                                                  engine_power: node.at_xpath('engine_power').text, 
                                                  engine_capacity: engine_capacity)
      

      gearbox_name = node.at_xpath('gearbox').text
      abbreviations = {
        'Автоматическая' => 'АКПП',
        'Механическая' => 'МКПП',
        'Автомат вариатор' => 'CVT',
        'Автомат робот' => 'РКПП'
      }
      abbreviation = abbreviations[gearbox_name]
      gearbox_type = GearboxType.find_or_create_by(name: gearbox_name) do |gt|
        gt.abbreviation = abbreviation
      end

      # Если запись уже существует, обновите сокращение, если оно отсутствует
      if gearbox_type.abbreviation.blank?
        gearbox_type.update(abbreviation: abbreviation)
      end

      # Использование значения по умолчанию "unknown" для drive
      drive_name = node.at_xpath('drive')&.text || "unknown"
      drive_type = DriveType.find_or_create_by(name: drive_name)

      # Создайте запись автомобиля
      car = Car.new(
        model: model,
        brand: brand,
        generation: generation,
        year: node.at_xpath('year').text.to_i,
        price: node.at_xpath('price').text.to_d,
        description: node.at_xpath('modification_id').text,
        color: color,
        body_type: body_type,
        engine_type: engine_type,
        gearbox_type: gearbox_type,
        drive_type: drive_type,
        # Добавьте другие поля, если необходимо
      )

      text_to_number = {
        "ноль" => 0,
        "один" => 1,
        "два" => 2,
        "три" => 3,
        "четыре" => 4,
        "пять" => 5,
        "шесть" => 6,
        "семь" => 7,
        "восемь" => 8,
        "девять" => 9,
        "десять" => 10
      }

      # Пример строки
      

      if car.save
        puts "Car created for: #{mark_name} #{model_name} #{generation_name}"

        # Проверка на существование VIN
        vin = node.at_xpath('vin').text
        if HistoryCar.exists?(vin: vin)
          puts "History already exists for car VIN: #{vin}, skipping creation."
        else
          owners_number_text = node.at_xpath('owners_number').text.downcase.split.first
          # Извлечение числового значения
          owners_number = text_to_number[owners_number_text] || owners_number_text.scan(/\d+/).first.to_i
          # Создайте историю автомобиля
          history_car = HistoryCar.new(
            car: car,
            vin: vin,
            last_mileage: node.at_xpath('run').text.to_i,
            previous_owners: owners_number.to_i,
            # Установите другие поля истории, если они есть в XML
          )

          if history_car.save
            puts "History created for car VIN: #{vin}"
          else
            puts "Failed to create history for car VIN: #{vin}"
            puts history_car.errors.full_messages.join(", ")
          end
        end

        # Сохраните изображения
        node.xpath('images/image').each do |image_node|
          image = Image.create(
            car: car,
            url: image_node.text,
            is_primary: false # или определите логику для основного изображения
          )
          if image.save
            puts "Image created for car: #{car.id}"
          else
            puts "Failed to create image for car: #{car.id}"
            puts image.errors.full_messages.join(", ")
          end
        end
      else
        puts "Failed to create car for VIN: #{vin}"
        puts car.errors.full_messages.join(", ")
      end
    end
  end
end
