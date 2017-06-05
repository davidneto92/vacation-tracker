Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get 'about', to: 'home#about'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]
  resources :users #, only: [:show, :destroy]
  resources :parks, only: [:show, :index]
  resources :vacations

  resources :vacations do
    resources :visits, except: [:show, :index]
  end

  namespace :api do
    namespace :v1 do
      resources :visits, only: [:index]
    end
  end

  root to: "home#show"
end
