# config/routes.rb
Rails.application.routes.draw do
  root to: "sessions#new"
  get '/usuarios/alterar_senha', to: 'usuarios#alterar_senha_form', as: 'alterar_senha_form'
  resources :importadados, only: [:new, :create]
  resources :usuarios do
    member do
      get :edit
      patch :update
      post :alterar_senha # Adicionando esta linha
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :respostas, only: [:index, :show]
  resources :formularios
  resources :templates # Adicionando esta linha
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/emails"
  end
end