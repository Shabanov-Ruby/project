Rails.application.routes.draw do
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
  resources :cars, only: [:index, :show]
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

  #Маршруты для клиентов
  get 'cars' => 'cars#index'#Список автомобилей
  get 'last_cars' => 'cars#last_cars'#Последние 20 автомобилей
  get 'cars_count' => 'cars#cars_count'#Количество автомобилей
  get 'car_details' => 'cars#car_details'#Детали автомобиля
  get 'filters', to: 'cars#filters'#Фильтры для автомобилей
  get 'cars/:id' => 'cars#show'#Показать автомобиль
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
  
end
