# frozen_string_literal: true

Rails.application.routes.draw do

  mount StripeEvent::Engine, at: '/api/v1/payments/webhook' 

  if Rails.env.test?
    namespace :test do
      resource :session, only: %i[create]
    end
  end

  get '/api/health', to: 'api_base#alive'

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do

      resources :organizations, except: %i[ create delete update ] do
        resources :reviews, only: %i[index], controller: 'organizations/reviews'
      end

      resources :organization_requests, only: %i[create index show]

      resources 'organization-manage', controller: 'organization_manage', as: :organization_manage do
        resources :stats, only: %i[index], controller: 'organization_manage/stats'

        resources :tax_incomes, only: %i[index], controller: 'organization_manage/tax_incomes'

        resources :lawyer_profiles, only: %i[index], controller: 'organization_manage/lawyer_profiles'

        resources :payouts, only: %i[index], controller: 'organization_manage/payouts'

        resources :transactions, only: %i[index], controller: 'organization_manage/transactions'

        resources :subscription, controller: 'organization_subscription', only: %i[create] do
          get :retrieve, to: 'organization_subscription#retrieve', on: :collection
        end
      end

      resources :transactions, only: %i[index]

      resources :payouts, only: %i[index]

      resources :reviews, only: %i[create]

      resources :appointments

      resources :lawyer_profiles

      resources :estimations do
        post :estimate, on: :collection
        get :my_estimation, on: :collection
        post :estimation_from_jwt, on: :collection
      end

      resources :tax_incomes, as: :tax_incomes do
        post 'create_payment_intent', to: 'tax_incomes#checkout', on: :member
        get :payment_data, on: :member
        get :documents, on: :member
      end
      

      resources :accounts, except: %i[delete] do
        get :history, to: 'account_history#index', as: :history, on: :member
        get :webauthn_keys, to: 'webauthn#index', as: :account_webauthn_keys, on: :member
        get :me, as: :logged_in, on: :collection
        post :resend_confirmation, as: :resend_confirmation, on: :member
        post 'stripe-customer-portal', as: :stripe_customer_portal, on: :collection
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
