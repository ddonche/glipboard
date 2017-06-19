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
      get :members
    end
    resources :posts do
      member do
        put 'like', to: 'posts#upvote'
        put 'dislike', to: 'posts#downvote'
      end
      resources :responses do
        member do
          put 'like', to: 'responses#upvote'
          put 'dislike', to: 'responses#downvote'
        end
      end
    end
    resources :categories
  end
  
  get 'tags/:tag', to: 'tags#show', as: :tag
  get 'tags', to: 'tags#index'
  match '/users', to: 'users#index', via: 'get'
  match '/users/:id', to: 'users#show', via: 'get'
  match '/featured', to: 'articles#featured', via: 'get'
  match '/drafts', to: 'articles#drafts', via: 'get'
  match '/help', to: 'pages#help', via: 'get'

  #devise_for :users, :path_prefix => 'd'
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :relationships,       only: [:create, :destroy]
  resources :memberships,         only: [:create, :destroy]
  resources :mentorships,         only: [:create, :destroy]
  resources :messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]
  match '/conversations', to: 'conversations#index', via: 'get'
end
