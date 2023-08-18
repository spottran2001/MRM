Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  root 'home#page_login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "page_usinfo", to: 'home#page_usinfo'
  get "statistic", to: 'home#page_stats' 
  get "reports", to: 'home#report' 
end
