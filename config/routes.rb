require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  resources :inmet_weather_data
  mount Sidekiq::Web => '/sidekiq'


  resources :noa_weather_stations do
    get 'start_import', on: :collection
  end

  resources :inmet_weather_stations do 
    get 'start_import', on: :collection
    get 'start_import_data', on: :collection
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#index"
end
