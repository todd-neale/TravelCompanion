Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "converter#index"

  resources :converter, only: [:index]
  resources :splitter, only: [:index]

  namespace :api do
    get 'get_data', to: 'currency#get_data'
  end

  resources :user, only: [:edit, :update]
end
