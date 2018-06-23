Rails.application.routes.draw do
  resources :logs
  resources :categories
  resources :items do 
    resources :logs, only: [:index, :show, :new, :edit, :create]
    resources :categories, only: [:index, :show, :new, :edit, :create]
  end
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'past_due', to: "logs#past_due"
  get 'upcoming', to: "logs#upcoming"

  get 'logs/:id/log_data', to: 'logs#log_data'

  root "items#index"
end
