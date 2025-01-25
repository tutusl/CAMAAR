Rails.application.routes.draw do
  resources :usuarios
  resources :sessions, only: [:new, :create, :destroy]
end
