Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  resources :directories, only: %i(show new create edit update destroy) do
    resources :fileitems, only: %i(show new create edit update destroy) do
      member do
        get :download
      end
    end
  end

  resource :directory do
    collection do
      post :move, :copy, :share
    end
  end

  resource :fileitem do
    collection do
      post :move, :copy, :share
    end
  end

  resources :events, only: %i(index)
end
