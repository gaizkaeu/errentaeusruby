# frozen_string_literal: true

Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/api/v1/payments/webhook' 

  if Rails.env.test?
    namespace :test do
      resource :session, only: %i[create]
    end
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do

      resources :appointments

      resources :estimations do
        post :estimate, on: :collection
        get :my_estimation, on: :collection
        post :estimation_from_jwt, on: :collection
      end

      scope :lawyers do
        get ':id', to: 'lawyers#show', as: :lawyer
      end

      resources :tax_incomes, as: :tax_incomes do
        post 'create_payment_intent', to: 'tax_incomes#checkout', on: :member
        get :payment_data, on: :member
        get :documents, on: :member
      end

      post :push, to: "push#send_push"

      scope '/accounts' do
        get ':id/history', to: 'account_history#index', as: :account_history
        get '', to: 'accounts#index', as: :accounts
        put ':id', to: 'accounts#update', as: :account_update
        get :me, to: 'accounts#me', as: :account_logged_in
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
