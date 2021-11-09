Rails.application.routes.draw do
  # get 'comments/index'
  # get 'comments/new'
  # get 'comments/show'
  # get 'comments/edit'
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"
  # get 'tasks/new'
  # get 'tasks/index'
  # get 'tasks/show'
  # get 'tasks/edit'
  #get 'cards/filter'
  resources :tasks
  # resources :comments
  #get 'cards/index'
  #get 'cards/show'
  #get 'cards/new'
  #get 'cards/edit'
  get 'home/index'
  resources :boards do
    resources :lists do
      resources :cards do
        resources :comments
        member do
          get :delete
          get :filter
          
        end
      end

      member do
        get :delete
      end
    end
    member do
      get :delete
    end
  end
  
  #devise_for :users
  #root 'home#index'
  #devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html 
  devise_for :users, :controllers => {
    :registrations => "users/registrations",
    :sessions => "users/sessions",
    :passwords => "users/passwords",
    :confirmations => "users/confirmations",
    :invitations => "users/invitations"
  }

  devise_scope :user do
    authenticated :user do
      root 'boards#index', as: :root
    end
    unauthenticated do
      root "users/sessions#new", as: :unauthenticated_root
    end
  end
end
