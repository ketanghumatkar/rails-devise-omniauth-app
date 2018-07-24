GitOmni::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :visitors
  root to: 'visitors#index'
end
