require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  resources :inmet_weather_data
  mount Sidekiq::Web => '/sidekiq'

  resources :users_project, only: [:index, :create, :destroy, :show] do
    patch 'update_user', to: 'users_project#update', on: :collection
    patch 'update_admin', to: 'users_project#update_admin', on: :collection
  end

  resources :noa_weather_stations do
    get 'start_import', on: :collection
  end

  resources :inmet_weather_stations do 
    get 'start_import', on: :collection
    get 'start_import_data', on: :collection
  end

  devise_for :users


  resources :dashboard do
    get 'grafico', on: :collection
  end

  resources :log_erros

  # Defines the root path route ("/")
  root "dashboard#index"
end
