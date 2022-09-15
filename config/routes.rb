Rails.application.routes.draw do
  root 'home#index'

  get '*path', to: 'home#index', via: :all

  namespace :api do
    namespace :v1 do
      resources :estimations do 
        post :estimate, on: :collection
      end
      get :logged_in, to: 'accounts#logged_in'
      devise_for :users, module: "api/v1/authg", defaults: { format: :json }
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
