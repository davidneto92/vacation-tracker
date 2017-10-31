Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  resources :sessions, only: [:create, :destroy]

  root to: "home#show"
  get 'about', to: 'home#about'

  get 'generator', to: 'generator#index'
  get 'generator/results', to: 'generator#show'

  resources :users
  resources :users do
    get 'user_visits_download', to: 'users#user_visits_download'
  end

  resources :parks, only: [:show, :index]
  resources :vacations

  resources :vacations do
    resources :visits, except: [:show, :index]
  end

  resources :saved_trips

  namespace :api do
    namespace :v1 do
      resources :vacations, only: [:index, :show]
      resources :user_visits, only: [:show]
      resources :parks, only: [:index]
    end
  end

end
