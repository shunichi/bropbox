Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  resources :directories, only: %i(show new create edit update destroy) do
    member do
      post :move, :copy, :share
    end
  end
end
