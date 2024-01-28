require 'sidekiq/web'

Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  post '/resend_confirmation', to: 'users#resend_confirmation', as: 'resend_confirmation'
  resources :profile, only: [:index, :edit, :update]
  mount Sidekiq::Web => '/sidekiq'
end
