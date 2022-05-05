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
    resources :categories
    resources :category_rewards
    resources :company_values
    resources :rewards
    resources :orders, only: %i[index update]
    resources :employees do
      collection do
        get 'edit_kudos_for_all'
        patch 'update_kudos_for_all'
      end
    end
  end
end
