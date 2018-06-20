Rails.application.routes.draw do
  resources :logs
  resources :categories
  resources :items
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "items#index"
end
