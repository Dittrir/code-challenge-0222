Rails.application.routes.draw do
  root 'welcome#index'

  get '/dashboard', to: 'users#show'
  
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
end
