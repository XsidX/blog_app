Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  # Define route for users in association with posts
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create]
    end
  end

  namespace :api do
    namespace :v1 do
      post :auth, to: "authentication#create"
      resources :users, only: [:index] do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
end
