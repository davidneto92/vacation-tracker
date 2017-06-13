Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'about', to: 'home#about'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  resources :users #, only: [:show, :destroy]
  resources :users do
    get 'user_visits_download', to: 'users#user_visits_download'
  end

  resources :parks, only: [:show, :index]
  resources :vacations

  resources :vacations do
    resources :visits, except: [:show, :index]
  end

  # api to map a single vacation
  namespace :api do
    namespace :v1 do
      resources :vacations, only: [:index, :show]
    end
  end

  # api for all of user's visits
  namespace :api do
    namespace :v1 do
      resources :user_visits, only: [:show]
    end
  end

  root to: "home#show"
end
