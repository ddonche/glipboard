Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
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
      resources :notations
    end
  end
  
  resources :glips do
    member do
      put 'like', to: 'glips#upvote'
      put 'dislike', to: 'glips#downvote'
      get :toggle_status
      get :toggle_active
      get :helpers
    end
    resources :comments do
      member do
        put 'like', to: 'comments#upvote'
        put 'dislike', to: 'comments#downvote'
      end
      resources :notations
    end
    resources :milestones do
      member do
        patch :complete
      end
    end
    resources :logs
  end
  
  resources :groups do
    member do
      get :members
      get :toggle_role
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
      resources :remarks
      end
    end
    resources :categories
  end
  
  resources :podcasts do
    match '/feed', to: 'podcasts#feed', via: 'get', format: 'rss'
    resources :episodes do
      member do
        put 'like', to: 'episodes#upvote'
        put 'dislike', to: 'episodes#downvote'
      end
      resources :comments
    end
  end
  
  resources :notifications do
    member do
      get :toggle_read
    end
  end
  
  get 'tags/:tag', to: 'tags#show', as: :tag
  get 'tags', to: 'tags#index'
  match '/users', to: 'users#index', via: 'get'
  match '/users/:id', to: 'users#show', via: 'get'
  match '/reputable', to: 'users#reputable', via: 'get'
  match '/featured', to: 'articles#featured', via: 'get'
  match '/drafts', to: 'articles#drafts', via: 'get'
  match '/help', to: 'pages#help', via: 'get'
  match '/about', to: 'pages#about', via: 'get'
  match '/congrats', to: 'pages#congrats', via: 'get'
  match '/content', to: 'pages#content', via: 'get'

  #devise_for :users, :path_prefix => 'd'
  resources :users do
    member do
      get :following, :followers
      get :glips
      get :articles
      get :groups
      get :logs
    end
  end
  
  resources :relationships,       only: [:create, :destroy]
  resources :memberships,         only: [:create, :destroy]
  resources :participations,      only: [:create, :destroy]
  resources :mentorships,         only: [:create, :destroy]
  resources :messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]
  match '/conversations', to: 'conversations#index', via: 'get'
end
