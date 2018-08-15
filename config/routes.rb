Rails.application.routes.draw do
  devise_for :users
  resources :links, path: "news"
  resources :notes

  root "home#index" # to: redirect("/news")
end
