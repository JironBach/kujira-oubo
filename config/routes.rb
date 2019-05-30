Rails.application.routes.draw do
  devise_for :users
  root 'regist#new'

end
