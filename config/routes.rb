# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/api/v1/payments/webhook' 
  mount Sidekiq::Web => '/sidekiq'

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :appointments
      resources :estimations do
        post :estimate, on: :collection
        get :my_estimation, on: :collection
        post :estimation_from_jwt, on: :collection
      end
      get 'lawyers/:id', to: 'lawyers#show'
      resources :tax_incomes do
        post 'create_payment_intent', to: 'tax_incomes#checkout', on: :member
        get :payment_data, on: :member
        get :documents, on: :member
      end

      get :logged_in, to: 'accounts#logged_in'
      get 'accounts/:id', to: 'accounts#show'

      devise_for :users, module: 'api/v1/auth', class_name: "Api::V1::User", defaults: { format: :json }, controllers: { omniauth_callbacks: 'api/v1/auth/omniauth_callbacks'}

      resources :documents do
        delete 'delete_document_attachment/:id_attachment', on: :member, to: 'documents#delete_document_attachment'
        post :add_document_attachment, on: :member
        post :export_document, on: :member
        get :history, on: :member
      end
    end
  end

  get '/manifest.v1.webmanifest', to: 'statics#manifest', as: :webmanifest
  root 'react#index'
  get '/*path', to: "react#index", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end
end
