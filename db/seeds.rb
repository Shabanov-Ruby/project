# db/seeds.rb
require 'faker'

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
