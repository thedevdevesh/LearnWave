# frozen_string_literal: true

Rails.application.routes.draw do
  resources :lessons
  devise_for :admins, skip: [:registration]
  devise_for :users
  resources :courses do
    resources :lessons
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  authenticated :admin_user do
    root to: 'admin#index', as: :admin_root
  end

  resources :checkouts, only: [:create]

  namespace :admin do
    resources :courses do
      resources :lessons
    end
    resources :users
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'admin' => 'admin#index'
  post '/webhook' => 'webhooks#stripe'

  # Defines the root path route ("/")
  root 'courses#index'
end
