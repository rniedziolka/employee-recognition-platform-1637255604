# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin_users'
  devise_for :employees, path: 'employees'

  get 'pages/home'
  root 'kudos#index'

  resources :kudos

  namespace :admin do
    root to: 'pages#dashboard', as: :root
    resources :kudos
  end
end
