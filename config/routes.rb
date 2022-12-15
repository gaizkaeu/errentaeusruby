# frozen_string_literal: true

Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/api/v1/payments/webhook' 

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do

      namespace :auth do
        post 'sign_up', to: 'registrations#create', as: :account_sign_up
        post 'sign_in', to: 'sessions#create', as: :account_sign_in
        delete 'logout', to: 'sessions#destroy', as: :account_sign_out
        post 'google', to: 'sessions#google', as: :google_callback
      end

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

      post :push, to: "push#send_push"

      scope '/accounts' do
        get :logged_in, to: 'accounts#logged_in', as: :account_logged_in
        get '', to: 'accounts#index', as: :accounts
        get ':id', to: 'accounts#show', as: :account
        post ':id/resend_confirmation', to: 'accounts#resend_confirmation', as: :account_resend_confirmation
      end

      resources :documents do
        delete 'delete_document_attachment/:id_attachment', on: :member, to: 'documents#delete_document_attachment', as: "delete_document_attachment"
        post :add_document_attachment, on: :member
        post :export_document, on: :member
        get :history, on: :member
      end
    end
  end
end
