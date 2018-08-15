Rails.application.routes.draw do
  devise_for :users
  resources :notes

  scope(path_names: { new: "add" }) do
    resources :links, path: "news"
  end

  root "home#index" # to: redirect("/news")
end
