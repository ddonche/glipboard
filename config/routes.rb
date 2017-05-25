Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, 
    controllers: { registrations: "registrations" }
  
  resources :articles do
    member do
      put 'like', to: 'articles#upvote'
      put 'dislike', to: 'articles#downvote'
      get :toggle_feature
      get :toggle_status
    end
    resources :comments do
      member do
        put 'like', to: 'comments#upvote'
        put 'dislike', to: 'comments#downvote'
      end
    end
  end
  
  resources :glips do
    member do
      put 'like', to: 'glips#upvote'
      put 'dislike', to: 'glips#downvote'
      get :toggle_status
    end
    resources :comments do
      member do
        put 'like', to: 'comments#upvote'
        put 'dislike', to: 'comments#downvote'
      end
    end
    resources :logs
  end
  
  get 'tags/:tag', to: 'tags#show', as: :tag

  match '/users', to: 'users#index', via: 'get'
  match '/users/:id', to: 'users#show', via: 'get'
  
  #devise_for :users, :path_prefix => 'd'
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :relationships,       only: [:create, :destroy]
end
