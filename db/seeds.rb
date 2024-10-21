# db/seeds.rb
require 'faker'

brands_data = [
  { name: 'Audi' },
  { name: 'BMW' },
  { name: 'Mercedes' },
  { name: 'Toyota' },
  { name: 'Honda' },
  { name: 'Volkswagen' },
  { name: 'Ford' },
  { name: 'Chevrolet' },
  { name: 'Hyundai' },
  { name: 'Kia' }
]

brands = {}
brands_data.each do |brand_data|
  brand = Brand.create!(
    name: brand_data[:name],
  )
  brands[brand.name] = brand
  puts "Created brand: #{brand.name}"
end

puts "Created #{Brand.count} brands"

models_data = [
  { brand: 'Audi', name: 'A4' },
  { brand: 'Audi', name: 'Q5' },
  { brand: 'Audi', name: 'A6' },
  { brand: 'BMW', name: '3 Series' },
  { brand: 'BMW', name: 'X5' },
  { brand: 'BMW', name: '5 Series' },
  { brand: 'Mercedes', name: 'C-Class' },
  { brand: 'Mercedes', name: 'E-Class' },
  { brand: 'Mercedes', name: 'GLE' },
  { brand: 'Toyota', name: 'Camry' },
  { brand: 'Toyota', name: 'RAV4' },
  { brand: 'Toyota', name: 'Corolla' },
  { brand: 'Honda', name: 'Civic' },
  { brand: 'Honda', name: 'CR-V' },
  { brand: 'Honda', name: 'Accord' },
  { brand: 'Volkswagen', name: 'Golf' },
  { brand: 'Volkswagen', name: 'Passat' },
  { brand: 'Volkswagen', name: 'Tiguan' },
  { brand: 'Ford', name: 'Focus' },
  { brand: 'Ford', name: 'Mustang' },
  { brand: 'Ford', name: 'F-150' },
  { brand: 'Chevrolet', name: 'Cruze' },
  { brand: 'Chevrolet', name: 'Malibu' },
  { brand: 'Chevrolet', name: 'Silverado' },
  { brand: 'Hyundai', name: 'Elantra' },
  { brand: 'Hyundai', name: 'Tucson' },
  { brand: 'Hyundai', name: 'Santa Fe' },
  { brand: 'Kia', name: 'Optima' },
  { brand: 'Kia', name: 'Sportage' },
  { brand: 'Kia', name: 'Sorento' }
]

models = {}
models_data.each do |model_data|
  brand = brands[model_data[:brand]]
  model = Model.create!(name: model_data[:name], brand: brand)
  models["#{model.brand.name} #{model.name}"] = model
  puts "Created model: #{model.name} for #{brand.name}"
end

generations_data = [
  { model: 'Audi A4', name: 'B8', start_date: '2008-01-01', end_date: '2015-12-31', modernization: 'Обновленный дизайн фар и решетки радиатора, улучшенная система MMI' },
  { model: 'Audi A4', name: 'B9', start_date: '2016-01-01', end_date: Date.today.to_s, modernization: 'Новая платформа MLB Evo, виртуальная приборная панель Audi Virtual Cockpit' },
  { model: 'Audi Q5', name: '8R', start_date: '2008-01-01', end_date: '2017-12-31', modernization: 'Рестайлинг' },
  { model: 'Audi Q5', name: 'FY', start_date: '2017-01-01', end_date: Date.today.to_s, modernization: 'Рестайлинг' },
  { model: 'BMW 3 Series', name: 'F30', start_date: '2011-01-01', end_date: '2019-12-31', modernization: 'Рестайлинг' },
  { model: 'BMW 3 Series', name: 'G20', start_date: '2019-01-01', end_date: Date.today.to_s, modernization: 'Рестайлинг' },
  { model: 'Mercedes C-Class', name: 'W204', start_date: '2007-01-01', end_date: '2014-12-31', modernization: 'Рестайлинг' },
  { model: 'Mercedes C-Class', name: 'W205', start_date: '2014-01-01', end_date: '2021-12-31', modernization: 'Рестайлинг' },
  { model: 'Mercedes C-Class', name: 'W206', start_date: '2021-01-01', end_date: Date.today.to_s, modernization: 'Рестайлинг' },
  { model: 'Toyota Camry', name: 'XV50', start_date: '2011-01-01', end_date: '2017-12-31', modernization: 'Рестайлинг' },
  { model: 'Toyota Camry', name: 'XV70', start_date: '2017-01-01', end_date: Date.today.to_s, modernization: 'Рестайлинг' },
  { model: 'Honda Civic', name: '9th Gen', start_date: '2011-01-01', end_date: '2015-12-31', modernization: 'Рестайлинг' },
  { model: 'Honda Civic', name: '10th Gen', start_date: '2015-01-01', end_date: '2021-12-31', modernization: 'Рестайлинг' },
  { model: 'Honda Civic', name: '11th Gen', start_date: '2021-01-01', end_date: Date.today.to_s, modernization: 'Рестайлинг' },
  { model: 'BMW 3 Series', name: 'F30', start_date: '2011-01-01', end_date: '2019-12-31' },
  { model: 'BMW 3 Series', name: 'G20', start_date: '2019-01-01', end_date: Date.today.to_s },
  { model: 'BMW X5', name: 'F15', start_date: '2013-01-01', end_date: '2018-12-31' },
  { model: 'BMW X5', name: 'G05', start_date: '2018-01-01', end_date: Date.today.to_s },
  { model: 'Mercedes C-Class', name: 'W204', start_date: '2007-01-01', end_date: '2014-12-31' },
  { model: 'Mercedes C-Class', name: 'W205', start_date: '2014-01-01', end_date: '2021-12-31' },
  { model: 'Mercedes C-Class', name: 'W206', start_date: '2021-01-01', end_date: Date.today.to_s },
  { model: 'Toyota Camry', name: 'XV50', start_date: '2011-01-01', end_date: '2017-12-31' },
  { model: 'Toyota Camry', name: 'XV70', start_date: '2017-01-01', end_date: Date.today.to_s },
  { model: 'Honda Civic', name: '9th Gen', start_date: '2011-01-01', end_date: '2015-12-31' },
  { model: 'Honda Civic', name: '10th Gen', start_date: '2015-01-01', end_date: '2021-12-31' },
  { model: 'Honda Civic', name: '11th Gen', start_date: '2021-01-01', end_date: Date.today.to_s },
  { model: 'Volkswagen Golf', name: 'Mk7', start_date: '2012-01-01', end_date: '2019-12-31' },
  { model: 'Volkswagen Golf', name: 'Mk8', start_date: '2019-01-01', end_date: Date.today.to_s },
  { model: 'Ford Focus', name: '3rd Gen', start_date: '2010-01-01', end_date: '2018-12-31' },
  { model: 'Ford Focus', name: '4th Gen', start_date: '2018-01-01', end_date: Date.today.to_s },
  { model: 'Chevrolet Cruze', name: '1st Gen', start_date: '2008-01-01', end_date: '2016-12-31' },
  { model: 'Chevrolet Cruze', name: '2nd Gen', start_date: '2016-01-01', end_date: '2022-12-31' },
  { model: 'Hyundai Elantra', name: 'MD', start_date: '2010-01-01', end_date: '2015-12-31' },
  { model: 'Hyundai Elantra', name: 'AD', start_date: '2015-01-01', end_date: '2020-12-31' },
  { model: 'Hyundai Elantra', name: 'CN7', start_date: '2020-01-01', end_date: Date.today.to_s },
  { model: 'Kia Optima', name: 'TF', start_date: '2010-01-01', end_date: '2015-12-31' },
  { model: 'Kia Optima', name: 'JF', start_date: '2015-01-01', end_date: '2020-12-31' },
  { model: 'Kia Optima', name: 'DL3', start_date: '2020-01-01', end_date: Date.today.to_s }
]

generations_data.each do |generation_data|
  model = models[generation_data[:model]]
  Generation.create!(
    model: model,
    name: generation_data[:name],
    start_date: generation_data[:start_date],
    end_date: generation_data[:end_date],
    modernization: generation_data[:modernization]
  )
  puts "Created generation: #{generation_data[:name]} for model #{model.name}"
end

puts "Created #{Brand.count} brands, #{Model.count} models, and #{Generation.count} generations"


colors = ['Красный', 'Синий', 'Зеленый', 'Черный', 'Белый', 'Серебристый']
colors.each { |name| Color.create!(name: name) }

# Создание типов кузоа
body_types = ['Седан', 'Хэтчбек', 'Универсал', 'Внедорожник', 'Купе']
body_types.each { |name| BodyType.create!(name: name) }

# Создание типов двигателей
engine_types = ['Бензиновый', 'Дизельный', 'Электрический', 'Гибридный']
engine_types.each { |name| EngineType.create!(name: name) }

# Создание типов коробок передач
gearbox_types = ['Механическая', 'Автоматическая', 'Роботизированная', 'Вариатор']
gearbox_types.each { |name| GearboxType.create!(name: name) }

# Создание типов привода
drive_types = ['Передний', 'Задний', 'Полный']
drive_types.each { |name| DriveType.create!(name: name) }

# Создание типов топлива
fuel_types = ['Бензин', 'Дизель', 'Электричество', 'Гибрид']
fuel_types.each { |name| FuelType.create!(name: name) }


brands = Brand.all.pluck(:id)
models = Model.all.pluck(:id)
colors = Color.all.pluck(:id)
body_types = BodyType.all.pluck(:id)
engine_types = EngineType.all.pluck(:id)
gearbox_types = GearboxType.all.pluck(:id)
drive_types = DriveType.all.pluck(:id)
fuel_types = FuelType.all.pluck(:id)

# Предполагаем, что у вас уже есть массив с ID поколений
generations = Generation.all.pluck(:id)

if brands.empty? || models.empty? || colors.empty? || body_types.empty? || engine_types.empty? || gearbox_types.empty? || drive_types.empty? || fuel_types.empty? || generations.empty?
  puts "Please seed associated tables (brands, models, generations, etc.) first!"
else
  50.times do
    model = Model.find(models.sample)  # Сначала находим модель
    Car.create!(
      model_id: model.id,
      brand_id: model.brand_id,  # Указываем brand_id из связанной модели
      generation_id: generations.sample,
      year: rand(2000..2023),
      price: rand(1000000..10000000),
      description: Faker::Vehicle.standard_specs.join(', '),
      color_id: colors.sample,
      body_type_id: body_types.sample,
      engine_type_id: engine_types.sample,
      gearbox_type_id: gearbox_types.sample,
      drive_type_id: drive_types.sample,
      fuel_type_id: fuel_types.sample
    )
  end
  puts "#{Car.count} cars created successfully!"
end

generations_data = [
  { name: 'Банк 1', country: 'Россия' },
  { name: 'Банк 2', country: 'Россия' },
  { name: 'Банк 3', country: 'Россия' },
]

# Создаем банки
banks = Bank.create([
  { name: "Сбербанк", country: "Russia" },
  { name: "Т Банк", country: "Russia" },
  { name: "Альфа Банк", country: "Russia" },
  { name: "АТБ", country: "Russia" },
  { name: "ВТБ", country: "Russia" },
  { name: "Газпромбанк", country: "Russia" },
  { name: "Банк Зенит", country: "Russia" },
  { name: "Ингосстрах Банк", country: "Russia" },
  { name: "Райффайзен Банк", country: "Russia" },
  { name: "Открытие", country: "Russia" },
  { name: "Экспобанк", country: "Russia" },
  { name: "Абсолют Банк", country: "Russia" },
  { name: "МКБ", country: "Russia" },
  { name: "Оранжевый Банк", country: "Russia" },
  { name: "Отп Банк", country: "Russia" },
  { name: "Россельхозбанк", country: "Russia" },
  { name: "Почта Банк", country: "Russia" },
  { name: "Ренессанс Кредит", country: "Russia" },
  { name: "ЛокоБанк", country: "Russia" },
  { name: "Совкомбанк", country: "Russia" },
  { name: "ПСБ", country: "Russia" },
  { name: "Юрганк", country: "Russia" },
  { name: "Хоум Банк", country: "Russia" },
  { name: "Банк Центр-Инвест", country: "Russia" },
  { name: "ДрайвКлик", country: "Russia" },
  { name: "ПримСоцБанк", country: "Russia" },
  { name: "Банк Авангард", country: "Russia" }
])

# Для каждого банка создаем 2-3 кредитные программы
banks.each do |bank|
  Program.create([
    { bank_id: bank.id, program_name: "Стандартная программа", interest_rate: 5.5 },
    { bank_id: bank.id, program_name: "Премиум программа", interest_rate: 4.5 },
    { bank_id: bank.id, program_name: "Экспресс кредит", interest_rate: 6.5 }
  ])
end
