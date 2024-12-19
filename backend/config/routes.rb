Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: 'users/registrations'
  }
  get '/member-data', to: 'members#show'
  devise_scope :user do
    delete 'delete_account/:id', to: 'users/registrations#delete_account', as: 'delete_account_user'
    get 'users/sign_out', to: 'users/sessions#destroy'
  end


  namespace :api do
    resources :post_subscriptions
    resources :comments
    resources :users
    resources :subscriptions
    resources :articles
  end
  
  resources :subscriptions, only: [:create, :destroy]
  resources :post_subscriptions, only: [:create, :destroy]
  resources :articles do
    resources :comments
  end
root "articles#index"
  
end