# config/routes.rb
Rails.application.routes.draw do
  root to: "sessions#new"
  resources :importadados, only: [:new, :create]
  resources :usuarios
  resources :sessions, only: [:new, :create, :destroy]
  resources :respostas, only: [:index, :show]
  resources :formularios
  resources :templates # Adicionando esta linha
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/emails"
  end
end