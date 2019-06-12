Rails.application.routes.draw do
  resources :s_groups
  post '/s_groups/search', to: 's_groups#search'
  post '/s_groups/batch_del', to: 's_groups#batch_del'
  post '/s_groups/conf', to: 's_groups#conf'
  patch '/s_groups/:id/conf', to: 's_groups#conf'
  resources :blacklists
  resources :notifications
  post '/notifications/new/', to: 'notifications#new'
  post '/notifications', to: 'notifications#set_page_limit'
  post '/notifications/batch_del', to: 'notifications#batch_del'
  post '/notifications/:id/conf', to: 'notifications#conf'

  root 'top#show'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end
=begin
  get '/top', to: 'top#show'
  post '/top', to:'top#show'
  get '/login', to: 'login#new'
  post '/login', to: 'login#create'
  get '/users/password/new', to: 'users/password#new'
  post '/users/password/create', to: 'users/password#create'
=end
  get '/setting_account', to: 'setting_account#show'
  post '/setting_account/:id', to: 'setting_account#post'
  post '/setting_account', to: 'setting_account#post'
  post '/setting_account_upd', to: 'setting_account_upd#post'
  post '/setting_account_upd_conf', to: 'setting_account_upd_conf#post'
  get '/setting_account_upd_conf', to: 'setting_account_upd_conf#post'
  post '/setting_account_update', to: 'setting_account_update#post'
  post '/setting_account_delete', to: 'setting_account_delete#post'
  get '/setting_account_create', to: 'setting_account_create#show'
  get '/setting_site', to: 'setting_site#show'
  get '/setting_site_create', to: 'setting_site_create#show'
  get '/setting_store', to: 'setting_store#show'
  get '/setting_store_create', to: 'setting_store_create#show'
  post '/setting_site_create_conf', to: 'setting_site_create_conf#post'
  post '/setting_site_submit', to: 'setting_site_submit#post'
  post '/setting_site_upd', to: 'setting_site_upd#post'
  post '/setting_site_delete', to: 'setting_site_delete#post'
  post 'setting_site_upd_conf', to: 'setting_site_upd_conf#post'
  post '/setting_site_update', to: 'setting_site_update#post'
  post '/setting_site/:id', to: 'setting_site#post'
  get '/setting_group', to: 'setting_group#show'
  post '/setting_group/:id', to: 'setting_group#post'
  get '/setting_group_create', to: 'setting_group_create#show'
  get '/setting_group_create_conf', to: 'setting_group_create_conf#show'
  post '/setting_group_create_conf', to: 'setting_group_create_conf#post'
  post '/setting_group_upd', to: 'setting_group_upd#post'
  get '/setting_applicant_display', to: 'setting_applicant_display#show'
  get '/setting_app_status', to: 'setting_app_status#show'
  post '/setting_app_status_create', to: 'setting_app_status_create#post'
  get '/setting_notification', to: 'setting_notification#show'
  get '/setting_notification_create', to: 'setting_notification_create#show'
  post '/setting_notification_create', to: 'setting_notification_create#post'
  post '/setting_notification_create_conf', to: 'setting_notification_create_conf#post'
  post '/setting_notification_upd', to: 'setting_notification_upd#post'
  get '/setting_auto_data_upload', to: 'setting_auto_data_upload#show'
  get '/setting_blacklist', to: 'setting_blacklist#show'
  post '/setting_blacklist/:id', to: 'setting_blacklist#post'
  post '/blacklist_add', to: 'blacklist_add#post'
  post '/setting_account_create_conf', to: 'setting_account_create_conf#post'

  if Rails.env.development? #開発環境の場合
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
