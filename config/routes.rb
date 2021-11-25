# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pages/home'
  root to: 'pages#home'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
