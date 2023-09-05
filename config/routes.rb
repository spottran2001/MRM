Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users do
    put "read_notifications", to: "users#read_notification"
  end
  resources :report_template
  resources :faculty
  resources :subject
  resources :report do
    put "submit_report", to: "report#submit_report!"
  end
  root 'users#show'
  get "statistic", to: 'home#page_stats' 
  get "reports", to: 'home#report' 
end
