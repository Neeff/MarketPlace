Rails.application.routes.draw do
  get 'dashboard', to: 'profiles#dashboard'
  get 'add_product', to: 'profiles#add_product'
  get 'add_credit_card', to: 'profiles#add_credit_card'
  get 'my_products', to: 'profiles#my_products'
  get 'products', to: 'products#index'
  get 'my_orders', to: 'profiles#orders'
  root 'profiles#dashboard'
  resources :users, only: %i[update] do
    resources :products, only: %i[create show update destroy edit] do
       resources :transactions, only: %i[create]

    end
  end
 devise_for :users, controllers: {
  omniauth_callbacks: 'omniauth_callbacks'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 end
