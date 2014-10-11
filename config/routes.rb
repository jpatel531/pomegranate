Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'home#index'

  get '/dashboard' => 'dashboard#show'

  get '/users/:id/repos' => 'users#repos'

  get '/users/:user_id/tutorials/:id/steps' => 'tutorials#steps'
  post '/users/:user_id/tutorials/:id/test_runner' => 'tutorials#test_runner'

  resources :users do
  	resources :tutorials
  end

end