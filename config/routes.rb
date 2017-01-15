Rails.application.routes.draw do
  devise_for :users

  post 'graphql' => 'graph#ql'
end
