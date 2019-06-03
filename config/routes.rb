Rails.application.routes.draw do
  root 'top#show'

  get '/top', to: 'top#show'
  post '/top', to:'top#show'
  get '/login', to: 'login#new'
  post '/login', to: 'login#create'
  get '/users/password/new', to: 'users/password#new'
  post '/users/password/create', to: 'users/password#create'
  get '/setting_account', to: 'setting_account#show'
  post '/setting_account/:id', to: 'setting_account#post'
  post '/setting_account', to: 'setting_account#post'
  post '/setting_account_upd', to: 'setting_account_upd#post'
  post '/setting_account_upd_conf', to: 'setting_account_upd_conf#post'
  get '/setting_account_upd_conf', to: 'setting_account_upd_conf#post'
  post '/setting_account_update', to: 'setting_account_update#post'
  post '/setting_account_delete', to: 'setting_account_delete#post'
=begin
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: 'top#show'
    end
    unauthenticated :user do
      root to: 'top#show', as: :unauthenticated_root
      get '/login', to: 'devise/sessions#new'
    end
  end
=end

  if Rails.env.development? #開発環境の場合
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
