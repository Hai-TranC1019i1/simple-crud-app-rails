Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'register', to: 'users#new', as: :register
  resources :users
  resources :articles do
    resources :comments
  end
  root 'home#index'
end
