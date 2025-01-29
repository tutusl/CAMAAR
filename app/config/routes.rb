Rails.application.routes.draw do
  root to: "sessions#new"
  get "importa_dados/import"
  post "importa_dados/import"
  resources :usuarios
  resources :sessions, only: [:new, :create, :destroy]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/emails"
  end
end

