Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :merchants do
        resources :find, only: :index
      end

      namespace :items do
        resources :find_all, only: :index
      end

      resources :items
      resources :merchants, only: [:index, :show]

      resources :merchants, only: :show do
        resources :items, only: :index
      end

      resources :items, only: :show do
        resources :merchant, only: :index
      end
    end
  end
end
