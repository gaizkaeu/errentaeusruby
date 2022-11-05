Rails.application.routes.draw do
  root 'home#index'

  get '*path', to: "home#index", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end

  namespace :api do
    namespace :v1 do
      resources :appointments
      resources :estimations do 
        post :estimate, on: :collection
        get :my_estimation, on: :collection
      end
      get 'lawyers/:id', to: 'lawyers#show'
      resources :tax_incomes do
        post :set_appointment, on: :member
        post :create_payment_intent, on: :member
        get :payment_data, on: :member
      end
      get :logged_in, to: 'accounts#logged_in'
      devise_for :users, module: "api/v1/auth", defaults: { format: :json }
      scope :payments do
        post :webhook, to: "payments#webhook"
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
