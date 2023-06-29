Rails.application.routes.draw do
  resources :noa_weather_stations
  resources :inmet_weather_stations
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#index"
end
