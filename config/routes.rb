Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  post '/resend_confirmation', to: 'users#resend_confirmation', as: 'resend_confirmation'

  resources :users, only: [:edit, :update]
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: "home#index"

end
