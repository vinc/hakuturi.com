Rails.application.routes.draw do
  devise_for :users
  resources :links
  resources :notes

  root to: "links#index"
end
