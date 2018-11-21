Rails.application.routes.draw do
  get 'mypages/index'
  get 'mypages/show'
  devise_for :users
  root to: 'toppages#index'

  resources :bicycles

end