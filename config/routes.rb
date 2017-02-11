Rails.application.routes.draw do
  devise_for :users

  get 'traits' => 'traits#index'

  get  'graphql/schema' => 'queries#schema'
  post 'graphql'        => 'queries#create'

  resources :queries, only: [:index, :show] do
    member do
      get :rerun
    end
  end

  root to: 'queries#index'
end
