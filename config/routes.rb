# frozen_string_literal: true

Rails.application.routes.draw do
  resources :documents do
    member do
      post :share
    end
    resources :layers, param: :layer, only: %i[create index show]
  end

  get "/login", to: "users#login"
  post "/login", to: "users#authenticate"
  get "/logout", to: "users#logout"

  namespace :api do
    post "share", action: "share"
    post "upload", action: "upload"
    get "documents", action: "documents"
    get "document/:id/:layer", action: "document"
    get "document/:id", action: "document"
  end

  root to: redirect("/documents")
end
