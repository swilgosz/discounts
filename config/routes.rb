Rails.application.routes.draw do
  resources :line_items, only: :destroy
  resources :orders, only: [:index]
  resource :order, only: [] do
    patch :close
  end

  mount RailsEventStore::Browser => '/res' if Rails.env.development?

  resources :products, only: [:new, :create, :destroy] do
    member do
      patch :buy
    end
  end

  root to: 'products#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
