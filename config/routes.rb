Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :find, only: :index
        resources :find_all, only: :index
        resources :most_items, only: :index
      end

      namespace :items do
        resources :find_all, only: :index
        resources :find, only: :index
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: :index
      end

      resources :items do
        resources :merchant, only: :index
      end

      namespace :revenue do
        resources :merchants, only: [:index, :show]
      end

      resources :revenue, only: :index
    end
  end
end
