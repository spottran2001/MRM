Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users do
    put "read_notifications", to: "users#read_notification"
    put "report_apply"
  end
  get "edit", to: "home#edit"
  get "staff", to: "home#staff"
  get 'page_stats', to: "home#page_stats"
  get "report_template_management", to: "report_template#report_template_management"
  resources :report_template do
    put 'submit_report_temp', to: 'report_template#submit_report'
  end
  post 'report_template/apply_temple', to: 'report_template#apply_temple'
  resources :faculty
  resources :academic
  resources :subject
  resources :report do
    put "save_draft", to: 'report#save_draft'
    put "return_report", to: 'report#return_report'
    put "report_apply", to: 'report#report_apply'
    put "submit_report", to: "report#submit_report!"
  end
  root 'users#show'
  get "statistic", to: 'home#page_stats' 
  get "reports", to: 'home#report' 
end
