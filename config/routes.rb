Rails.application.routes.draw do
  devise_for :users

  get 'traits' => 'traits#index'

  get  'graphql/schema' => 'queries#schema'
  post 'graphql'        => 'queries#create'

  resources :queries, only: [:index, :show] do
    member do
      patch :rerun
    end
  end
end
