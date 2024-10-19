Rails.application.routes.draw do
  # Проверка здоровья приложения
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # API ресурсы
  resources :images
  resources :fuel_types
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

  # Можно добавить корневой маршрут, если это необходимо
  # root "home#index"
  get 'cars' => 'cars#index'
  get 'cars/:brand' => 'cars#show'
  get 'cars/:brand/:model' => 'cars#show'
  get 'cars/:brand/:model/:generation' => 'cars#show'
end
