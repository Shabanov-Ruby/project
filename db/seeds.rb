AboutCompany.destroy_all
Contact.destroy_all
Admin.destroy_all
Credit.destroy_all
CallRequest.destroy_all
Buyout.destroy_all
Exchange.destroy_all
Installment.destroy_all
OrderStatus.destroy_all
Program.destroy_all
Bank.destroy_all










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

OrderStatus.create([
  { name: 'Новая' },
  { name: 'В обработке' },
  { name: 'Одобрена' },
  { name: 'Отклонена' },
  { name: 'Завершена' }
])
puts "Order statuses created successfully"

AboutCompany.create([
  { description: 'Компания «YouAuto» на автомобильном рынке функционирует с 2013 года. Мы посвятили много времени и усилий нашему профессионализму в продажах и обслуживании за эти годы. В автопарке нашего автосалона мы собрали множество автомобилей с пробегом, которые прошли техническую и юридическую экспертизу. Проверка каждого автомобиля начинается с этапа закупки и продолжается во время предпродажной подготовки.' },
  { description: 'В «YouAuto» представлены автомобили более 40 марок, что позволит Вам найти подходящий вариант в стенах одного автосалона. Мы создали комфортные и доступные условия для своих покупателей, позволяющие безопасно совершить покупку. Выгодные кредитные условия, подробная информация об автомобилях, техническая гарантия и подарки — то, ради чего люди приходят в наш автосалон.' },
  { description: 'Ждем Вас в «YouAuto»!' },
])
puts "About company created successfully"

Contact.create([
  { phone: '74992887610', 
    mode_operation: 'с 09:00 до 21:00 ежедневно', 
    auto_address: 'г. Москва, Ореховый бульвар, 26к1'},
])
puts "Contact created successfully"

Credit.create([
  { car_id: Car.first.id,
    name: "ТЕСТ",
    phone: "66666666666",
    credit_term: 66,
    initial_contribution: 666666,
    banks_id: Bank.first.id,
    programs_id: Program.first.id
  }
])
puts "Credit created successfully"

CallRequest.create([
  { car_id: Car.first.id,
    name: "ТЕСТ",
    phone: "66666666666",
    preferred_time: "с 11.00 до 12.00"
  }
])
puts "Call request created successfully"

Buyout.create([
  { name: "ТЕСТ", 
    phone: "66666666666",
    brand: "Toyota",
    model: "Corola 3.5",
    year: 2006,
    mileage: 130000
  }
])
puts "Buyout created successfully"

Exchange.create([
  { car_id: Car.first.id, 
    customer_car: "Toyota Corola 3.5", 
    name: "ТЕСТ", 
    phone: "66666666666", 
    credit_term: 66, 
    initial_contribution: 666666 
    
  }
])
puts "Exchange created successfully"

Installment.create([
  { car_id: Car.first.id, 
    name: "ТЕСТ", 
    phone: "66666666666", 
    credit_term: 66, 
    initial_contribution: 666666 
  }
])
puts "Installment created successfully"