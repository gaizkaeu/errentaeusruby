# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

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

      resources :emails, as: :email_contacts, only: %i[create]
      resources :calls, as: :call_contacts, only: %i[create]

      resources :organization_requests, only: %i[create index show]

      resources :tags, only: %i[index]

      resources 'organization-manage', controller: 'organization_manage', as: :organization_manage do

        resources :memberships, controller: 'organization_manage/memberships', only: %i[index create update destroy]
        resources :invitations, controller: 'organization_manage/invitations', only: %i[index create destroy update]
        resources :subscription, controller: 'organization_manage/subscriptions', only: %i[create] do
          get :retrieve, on: :collection
        end

        resources :calls, controller: 'organization_manage/calls', only: %i[index update] do
          post :start, on: :member
          post :end, on: :member
        end

        collection do
          resources :invitations, controller: 'organization_invitations', only: %i[show] do
            post :accept, on: :member
          end
        end
      end

      resources 'organization-memberships', controller: 'organization_memberships', as: :organization_memberships, only: %i[index]

      resources :reviews, only: %i[create]

      resources :accounts, except: %i[delete] do
        get :history, to: 'account_history#index', as: :history, on: :member
        get :webauthn_keys, to: 'webauthn#index', as: :account_webauthn_keys, on: :member
        get :me, as: :logged_in, on: :collection
        post :resend_confirmation, as: :resend_confirmation, on: :member
        post 'stripe-customer-portal', as: :stripe_customer_portal, on: :collection
      end
    end
  end
end
