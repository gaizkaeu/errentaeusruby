# frozen_string_literal: true

Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/api/v1/payments/webhook' 

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

      post :push, to: "push#send_push"

      mount_devise_token_auth_for 'Api::V1::User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
      }

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
