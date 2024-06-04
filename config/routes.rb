Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "converter#index"

  resources :converter, only: [:index]
  resources :splitter, only: [:index]

  get 'drinking-water', to: 'drinking_water#location'
  post 'drinking-water/process_location', to: 'drinking_water#process_location'

  namespace :api do
    get 'get_data', to: 'currency#get_data'
  end

  resources :user, only: [:edit, :update]
end
