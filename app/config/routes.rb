# frozen_string_literal: true

# config/routes.rb
Rails.application.routes.draw do
  root to: 'sessions#new'
  get '/password_reset', to: 'password_resets#new', as: 'new_password_reset'
  post '/password_reset', to: 'password_resets#create'
  get '/password_reset/:user/edit', to: 'password_resets#edit', as: 'edit_password_reset'
  patch '/password_reset/:user', to: 'password_resets#update', as: 'update_password_reset'
  resources :importadados, only: %i[new create]
  resources :usuarios do
    member do
      get :edit
      patch :update
      post :alterar_senha # Kept from feat/adding_more_tests branch
    end
  end
  resources :sessions, only: %i[new create destroy]
  resources :respostas, only: %i[index show]
  resources :formularios
  resources :templates

  mount LetterOpenerWeb::Engine, at: '/emails' if Rails.env.development?
end
