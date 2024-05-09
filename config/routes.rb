Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
  get "decouverte", to: "pages#decouverte"
  get "engagements", to: "pages#engagements"

  get 'dashboard', to: 'dashboard/dashboard#index', as: :dashboard
  get 'dashboard/generals', to: 'dashboard/generals#index', as: :dashboard_generals
  get 'dashboard/sentiers', to: 'dashboard/sentiers#index', as: :dashboard_sentiers
  get 'dashboard/points', to: 'dashboard/points#index', as: :dashboard_points
  get 'dashboard/decouverte', to: 'dashboard/decouverte#index', as: :dashboard_decouverte
  get 'dashboard/engagements', to: 'dashboard/engagement#index', as: :dashboard_engagement

  resources :sentiers do
    collection do
      get :themes
    end
  end

  resources :points
  resources :generals, only: [:new, :create, :edit, :update, :destroy]
  resources :decouvertes, only: [:new, :create, :edit, :update, :destroy]
  resources :engagements, only: [:new, :create, :edit, :update, :destroy]

end
