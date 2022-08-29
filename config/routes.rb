# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    resources :bulletins, only: %i[index show new create edit update]

    resource :session, only: %i[destroy]

    namespace :admin do
      root 'home#index'

      resources :bulletins, only: %i[index destroy]
      resources :categories, only: %i[index new create edit update destroy]
    end
  end
end
