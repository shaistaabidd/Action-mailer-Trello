Rails.application.routes.draw do
  
  #get 'cards/index'
  #get 'cards/show'
  #get 'cards/new'
  #get 'cards/edit'
  resources :boards do
    resources :lists do
      resources :cards do
        member do
          get :delete
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
