Rails.application.routes.draw do
  devise_for :users
  root 'regist#new'

  get '/login', to: 'login#login'
  post '/login', to: 'login#post'

  if Rails.env.development? #開発環境の場合
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
