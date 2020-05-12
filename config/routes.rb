Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :articles do
    resources :comments
  end
  root 'home#index'
end
