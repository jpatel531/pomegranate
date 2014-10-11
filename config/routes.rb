Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'tutorials#index'

  get '/dashboard' => 'dashboard#show'

  get '/users/:id/repos' => 'users#repos'

  resources :users do
  	resources :tutorials
  end

end