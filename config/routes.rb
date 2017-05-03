Rails.application.routes.draw do
  devise_for :users
  resources :blogs
  resources :glips
  
  root to: "glips#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
