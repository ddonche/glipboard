Rails.application.routes.draw do
  root to: "glips#index"

  get 'pages/home'
  get 'pages/about'
  get 'pages/contact'
  get 'tags/:tag', to: 'glips#index', as: :tag

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  
  resources :blogs do
    resources :comments
  end
  resources :glips do
    resources :comments
    resources :logs
  end

  match '/users', to: 'users#index', via: 'get'
  match '/users/:id', to: 'users#show', via: 'get'
  
  #devise_for :users, :path_prefix => 'd'
  resources :users, :only =>[:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
