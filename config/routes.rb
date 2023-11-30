Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users do
    put "read_notifications", to: "users#read_notification"
    put "report_apply"
  end 
  get "report_chart", to: "home#report_chart"
  get "report_upload", to: "home#report_upload"
  get "configuration_page", to: "home#configuration_page"
  get "review_report", to: "home#review_report"
  get "list_faculty", to: "home#list_faculty"
  get "list_subject", to: "home#list_subject"
  get "list_lecturer", to: "home#list_lecturer"
  get "list_staff", to: "home#list_staff"
  get "edit", to: "home#edit"
  get 'page_stats', to: "home#page_stats"
  get "report_template_management", to: "report_template#report_template_management"
  resources :report_template do
    put 'submit_report_temp', to: 'report_template#submit_report'
  end
  post 'report_template/apply_temple', to: 'report_template#apply_temple'
  resources :faculties
  resources :academic do
    member do 
      get "report_list"
      get "review_report"
      put "accept_report"
      put "reject_report"
    end
  end
  resources :subjects
  resources :report do
    put "save_draft", to: 'report#save_draft'
    put "send_report", to: 'report#send_report'
    put "return_report", to: 'report#return_report'
    put "report_apply", to: 'report#report_apply'
    put "submit_report", to: "report#submit_report!"
    get :download_attachment
  end
  root 'users#show'
  get "statistic", to: 'home#page_stats' 
  get "reports", to: 'home#report' 

end
