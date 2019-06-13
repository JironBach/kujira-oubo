Rails.application.routes.draw do
  resources :applicant_displays
  resources :s_groups
  post '/s_groups/search', to: 's_groups#search'
  post '/s_groups/batch_del', to: 's_groups#batch_del'
  post '/s_groups/conf', to: 's_groups#conf'
  patch '/s_groups/:id/conf', to: 's_groups#conf'
  resources :notifications
  post '/notifications/new/', to: 'notifications#new'
  post '/notifications', to: 'notifications#set_page_limit'
  patch '/notifications', to: 'notifications#update'
  post '/notifications/batch_del', to: 'notifications#batch_del'
  post '/notifications/conf', to: 'notifications#conf'
  post '/notifications/:id/conf', to: 'notifications#conf'
  resources :blacklists
  post '/blacklists/search', to: 'blacklists#search'
  post '/blacklists/batch_del', to: 'blacklists#batch_del'
  resources :auto_data_uploads
  resources :app_statuses

  resources :sites
  resources :accounts

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

  if Rails.env.development? #開発環境の場合
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
