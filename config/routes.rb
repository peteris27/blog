Rails.application.routes.draw do
  devise_for :users
  devise_for :models
  resources :authors
  root 'welcome#index'
  resources :articles do
    resources :comments
  end
end
