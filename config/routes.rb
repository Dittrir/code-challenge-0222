Rails.application.routes.draw do
  root 'posts#index'

  get '/dashboard', to: 'users#show'
  delete '/logout', to: 'users#logout'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
end
