Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  resources :directories, only: %i(show new create edit update destroy) do
    resources :fileitems, only: %i(show new create edit update destroy)
  end

  resource :directory do
    collection do
      get :tree
      post :move, :copy
    end
  end

  resources :shared_directories, only: %i(index) do
    resources :shared_sub_directories, only: %i(show)
  end

  resource :fileitem do
    collection do
      post :move, :copy
    end
  end

  resources :events, only: %i(index)

  resources :items, only: %i(index) do
    collection do
      get :search
    end
  end

  namespace :my do
    resources :directories, only: %i() do
      resources :shared_directories, only: %i(index new create destroy)
    end
    resources :fileitems, only: %i() do
      resources :shared_files, only: %i(index new create destroy)
    end
  end
end
