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
      get :helped
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
      get :helpers
    end
    resources :comments do
      member do
        put 'like', to: 'comments#upvote'
        put 'dislike', to: 'comments#downvote'
      end
    end
    resources :logs
  end
  
  resources :groups do
    member do
    end
    resources :posts do
      member do
        put 'like', to: 'posts#upvote'
        put 'dislike', to: 'posts#downvote'
      end
      resources :comments do
        member do
          put 'like', to: 'comments#upvote'
          put 'dislike', to: 'comments#downvote'
        end
      end
    end
  end
  
  get 'tags/:tag', to: 'tags#show', as: :tag
  match '/users', to: 'users#index', via: 'get'
  match '/users/:id', to: 'users#show', via: 'get'
  match '/featured', to: 'articles#featured', via: 'get'
  
  #devise_for :users, :path_prefix => 'd'
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :relationships,       only: [:create, :destroy]
  resources :mentorships,         only: [:create, :destroy]
end
