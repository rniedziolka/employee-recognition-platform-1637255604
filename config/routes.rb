# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin_users'
  devise_for :employees, path: 'employees'

  get 'pages/home'
  root 'kudos#index'

  resources :kudos
  resources :rewards, only: %i[index show]
  resources :orders, only: %i[index create]

  namespace :admin do
    root to: 'pages#dashboard', as: :root
    resources :kudos
    resources :company_values
    resources :rewards
    resources :orders, only: %i[index update]
  end
end
