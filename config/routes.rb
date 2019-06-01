Rails.application.routes.draw do
  root 'top#show'

  get '/top', to: 'top#show'
  post '/top', to:'top#show'
  get '/login', to: 'login#new'
  post '/login', to: 'login#create'
  get '/users/password/new', to: 'users/password#new'
  post '/users/password/create', to: 'users/password#create'
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
