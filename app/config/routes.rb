# config/routes.rb
Rails.application.routes.draw do
  root to: "sessions#new"
  get "importa_dados", to: "importa_dados#new"
  post "importa_dados/import", to: "importa_dados#import"
  resources :usuarios
  resources :sessions, only: [:new, :create, :destroy]
  resources :respostas, only: [:index, :show]
  resources :templates # Adicionando esta linha
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/emails"
  end
end