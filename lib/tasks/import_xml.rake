namespace :import do
  desc "Import cars and their history from XML"
  task cars: :environment do
    require 'nokogiri'
    require 'open-uri'

    # Путь к файлу XML
    file_path = Rails.root.join('app', 'assets', 'xml', 'hpbz0dmc.xml')

    # Чтение данных из файла
    xml_data = File.read(file_path)
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
        online_view_available: true
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
          history_car = HistoryCar.create(
            car: car,
            vin: vin,
            last_mileage: node.at_xpath('run').text.to_i,
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
            puts "History created for car: #{car.id}"
          else
            puts "History not created for car VIN: #{vin}"
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
          
        end
        puts "Image saved for car: #{car.id}"
        

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
          Extra.create(car: car, category: category, name: extra)
        end
      else
        puts "Failed to create car for VIN: #{vin}"
        puts car.errors.full_messages.join(", ")
      end
    end
  end
end
