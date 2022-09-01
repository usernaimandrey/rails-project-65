# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    get 'profile', to: 'users#show'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    resources :bulletins, only: %i[index show new create edit update] do
      member do
        patch :on_moderate
        patch :archive
      end
    end

    resource :session, only: %i[destroy]

    namespace :admin do
      root 'home#index'

      resources :bulletins, only: %i[index destroy] do
        member do
          patch :archive
          patch :publish
          patch :reject
        end
      end
      resources :categories, only: %i[index new create edit update destroy]
    end
  end
end
