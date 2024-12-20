Rails.application.routes.draw do
  root "kittens#index"
  resources :kittens

  get "/search", to: "kittens#search_results"
end
