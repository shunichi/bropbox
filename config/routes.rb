Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  resources :directories, only: %i(show new create edit update destroy) do
    resources :fileitems, only: %i(show new create edit update destroy)
  end

  resource :directory do
    collection do
      get :tree
      post :move, :copy, :share
    end
  end

  resource :fileitem do
    collection do
      post :move, :copy, :share
    end
  end

  resources :events, only: %i(index)

  resources :items, only: %i(index) do
    collection do
      get :search
    end
  end
end
