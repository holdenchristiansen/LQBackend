Rails.application.routes.draw do
  resources :lists
  resources :recipes
  resources :recipes_steps
  resources :ingredients
  resources :garnishes
  resources :categories
  resources :glasses

  resources :recipe_steps do
    post :sort, on: :collection
  end

  get 'sync' => 'sync#index'

  root to: 'visitors#index'
  devise_for :users
  resources :users

  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for "User", at: 'auth'
    end
  end

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'sync' => 'sync#create'
      end
    end
  end

end
