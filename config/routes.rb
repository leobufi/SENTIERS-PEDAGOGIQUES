Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"

  get 'dashboard', to: 'dashboard/dashboard#index', as: :dashboard
  get 'dashboard/generals', to: 'dashboard/generals#index', as: :dashboard_generals
  get 'dashboard/sentiers', to: 'dashboard/sentiers#index', as: :dashboard_sentiers
  get 'dashboard/points', to: 'dashboard/points#index', as: :dashboard_points
  get 'dashboard/decouverte', to: 'dashboard/decouverte#index', as: :dashboard_decouverte
  get 'dashboard/engagements', to: 'dashboard/engagement#index', as: :dashboard_engagement
  get 'dashboard/qrcodes', to: 'dashboard/qrcodes#index', as: :dashboard_qr_codes

  get 'themes', to: 'sentiers#themes', as: :themes_sentiers

  resources :sentiers do
    resources :roads, only: [:destroy], shallow: true
  end

  resources :points, except: [:index] do
    member do
      get :download_qr_code
    end
  end

  resources :generals, except: [:show, :index]
  resources :decouvertes, except: [:show]
  resources :engagements, except: [:show]
  resources :contacts, only: [:new, :create]

  resources :qrcodes, only: [:new, :create, :destroy] do
    member do
      get :download_qr_code
    end
  end



end
