Rails.application.routes.draw do
  resources :extra_names
  resources :extras
  resources :categories
  # Проверка здоровья приложения
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Маршруты для обработки бренда, модели и поколения через один экшен `show`
  #get 'cars/:brand_name(/:model_name(/:generation_name(/:car_id)))', to: 'cars#index', as: :car_details

  # Остальные ресурсы
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

  get 'cars' => 'cars#index'
  get 'last_cars' => 'cars#last_cars'
  get 'cars_count' => 'cars#cars_count'
  get 'cars/:id' => 'cars#show'
  get 'exchange' => 'exchanges#index'
  post 'exchange' => 'exchanges#create'
  get 'installment' => 'installments#index'
  post 'installment' => 'installments#create'
  get 'buyout' => 'buyouts#index'
  post 'buyout' => 'buyouts#create'
  get 'credit' => 'credits#top_programs'
  get 'credits' => 'credits#index '
  post 'credit' => 'credits#create'
  get 'credit/:id' => 'credits#show'
  
end
