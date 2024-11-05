# db/seeds.rb
require 'faker'



# Создаем банки
banks = Bank.create([
  { name: "Сбербанк", country: "Sberbank" },
  { name: "Т Банк", country: "T Bank" },
  { name: "Альфа Банк", country: "Alfa Bank" },
  { name: "АТБ", country: "ATB" },
  { name: "ВТБ", country: "VTB" },
  { name: "Газпромбанк", country: "Gazprombank" },
  { name: "Банк Зенит", country: "Zenit Bank" },
  { name: "Ингосстрах Банк", country: "Ingosstrakh Bank" },
  { name: "Райффайзен Банк", country: "Raiffeisen Bank" },
  { name: "Открытие", country: "Otkritie" },
  { name: "Экспобанк", country: "Expobank" },
  { name: "Абсолют Банк", country: "Absolut Bank" },
  { name: "МКБ", country: "MKB" },
  { name: "Оранжевый Банк", country: "Orange Bank" },
  { name: "Отп Банк", country: "OTP Bank" },
  { name: "Россельхозбанк", country: "Rosselkhozbank" },
  { name: "Почта Банк", country: "Post Bank" },
  { name: "Ренессанс Кредит", country: "Renescans Credit" },
  { name: "ЛокоБанк", country: "LokoBank" },
  { name: "Совкомбанк", country: "Sovcombank" },
  { name: "ПСБ", country: "PSB" },
  { name: "Юрганк", country: "Yurgang" },
  { name: "Хоум Банк", country: "HomeBank" },
  { name: "Банк Центр-Инвест", country: "Center-Invest" },
  { name: "ДрайвКлик", country: "DriveClick" },
  { name: "ПримСоцБанк", country: "Primsocbank" },
  { name: "Банк Авангард", country: "Bank Avangard" }
])

# Для каждого банка создаем 2-3 кредитные программы
banks.each do |bank|
  Program.create([
    { bank_id: bank.id, program_name: "Стандарт", interest_rate: 5.5 },
    { bank_id: bank.id, program_name: "Премиум", interest_rate: 4.5 },
    { bank_id: bank.id, program_name: "Экспресс", interest_rate: 6.5 }
  ])
end

puts "Banks and programs created successfully"

Admin.create(email: 'admin1@gmail.com', password: 'password')
Admin.create(email: 'admin2@gmail.com', password: '123456')
puts "Admin created successfully"
