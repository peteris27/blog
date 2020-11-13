Rails.application.routes.draw do
  resources :authors
  root 'welcome#index'
  resources :articles do
    resources :comments
  end
end
