Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users do
    put "read_notifications", to: "users#read_notification"
  end
  get "staff", to: "home#staff"
  get 'page_stats', to: "home#page_stats"
  get "report_template_management", to: "report_template#report_template_management"
  resources :report_template do
    put 'submit_report_temp', to: 'report_template#submit_report'
  end
  resources :faculty
  resources :subject
  resources :report do
    put "submit_report", to: "report#submit_report!"
  end
  root 'users#show'
  get "statistic", to: 'home#page_stats' 
  get "reports", to: 'home#report' 
end
