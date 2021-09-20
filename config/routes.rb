Rails.application.routes.draw do
  resources :line_items, only: :destroy
  resources :orders, only: [:index]

  mount RailsEventStore::Browser => '/res' if Rails.env.development?

  resources :products, only: [:index, :new, :create, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
