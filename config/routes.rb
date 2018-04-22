Rails.application.routes.draw do
  devise_for :users
  resources :links, path: "news"
  resources :notes

  root to: redirect("/news")
end
