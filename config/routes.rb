Rails.application.routes.draw do
  namespace :public do
  get 'sub_directories/show'
  end

  root to: 'home#index'

  devise_for :users

  resources :directories, only: %i(show new create edit update destroy) do
    member do
      post :publicate
    end
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

  resources :shared_files, only: %i(index show)

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
      resources :publicate_directories, only: %i(index new create destroy)
    end
    resources :fileitems, only: %i() do
      resources :shared_files, only: %i(index new create destroy)
    end
  end

  namespace :public do
    get '/directory/:id/:access_token', to: 'directories#show', as: 'directory'
    get '/sub_directory/:id', to: 'sub_directories#show', as: 'sub_directory'
  end
end
