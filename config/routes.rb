Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, 
    controllers: { registrations: "registrations" }
  
  resources :blogs do
    member do
      put 'like', to: 'blogs#upvote'
      put 'dislike', to: 'blogs#downvote'
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
  resources :users, :only =>[:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
