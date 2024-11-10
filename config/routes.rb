Rails.application.routes.draw do
  resources :engine_capacity_types
  resources :engine_power_types
  resources :engine_name_types
  resources :orders_call_requests
  resources :orders_buyouts
  resources :orders_exchanges
  resources :orders_installments
  resources :orders_credits
  resources :contacts
  resources :about_companies
  resources :order_statuses
  resources :admins, only: [:login]
  #Все ресурсы
  resources :extra_names
  resources :extras
  resources :categories
  resources :images
  resources :drive_types
  resources :gearbox_types
  resources :engine_types
  resources :body_types
  resources :colors
  resources :brands
  resources :generations
  resources :models
  resources :history_cars
  resources :call_requests
  resources :cars do
    collection do
      get :total_pages
    end
  end
  resources :banks
  resources :programs
  resources :installments
  resources :exchanges
  resources :buyouts
  resources :credits
  resources :trade_in_offers
  resources :installment_plans
  resources :credit_offers
  resources :offers
  resources :call_requests
  resources :admins, only: [:login]

  #Маршруты для клиентов
  get 'cars' => 'cars#index'#Список автомобилей
  get 'last_cars' => 'cars#last_cars'#Последние 20 автомобилей
  get 'cars_count' => 'cars#cars_count'#Количество автомобилей
  get 'car_details' => 'cars#car_details'#Детали автомобиля
  get 'cars/:id' => 'cars#show'#Показать автомобиль
  get 'filters', to: 'cars#filters'#Фильтры для автомобилей
  get 'car_ids', to: 'cars#car_ids'#Список идентификаторов автомобилей
  get 'exchange' => 'exchanges#index'#Обмен
  post 'exchange' => 'exchanges#create'#Создать обмен
  
  get 'installment' => 'installments#index'#Рассрочка
  post 'installment' => 'installments#create'#Создать рассрочку
  
  get 'buyout' => 'buyouts#index'#Выкуп
  post 'buyout' => 'buyouts#create'#Создать выкуп
  
  get 'credit' => 'credits#top_programs'#Топ программ
  get 'credits' => 'credits#index '#Список программ
  post 'credit' => 'credits#create'#Создать программу
  get 'credit/:id' => 'credits#show'#Показать программу

  post 'admins/login' => 'admins#login'#Авторизация
  
end
  