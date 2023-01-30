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

      resources :organizations do
        get :lawyers, on: :member
        get :reviews, on: :member
        post :reviews, on: :member, to: 'organizations#create_review'
        resources :manage, controller: 'organization_manage' do
          post 'accept/:lawyer_profile_id', to: 'organization_manage#accept', on: :collection, as: :accept
          post 'remove/:lawyer_profile_id', to: 'organization_manage#remove', on: :collection, as: :reject
          get 'lawyer/:lawyer_profile_id', to: 'organization_manage#lawyer', on: :collection, as: :lawyer
          get :lawyers, to: 'organization_manage#lawyers', on: :collection, as: :lawyers
          get :reviews, to: 'organization_manage#reviews', on: :collection, as: :reviews
          post 'create-subscription', to: 'organization_manage#create_subscription', on: :collection, as: :create_subscription
        end

        resources :stats, only: %i[index], controller: 'organization_stats'
      end

      resources :appointments

      resources :lawyer_profiles do
        get :me, on: :collection
      end

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
