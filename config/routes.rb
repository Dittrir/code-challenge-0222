Rails.application.routes.draw do
  root 'posts#index'

  get '/dashboard', to: 'users#show'
  delete '/logout', to: 'users#logout'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  # resources :posts, only: [:new, :show] do
  #   resources :comments, only: [:new, :show]
  # end
  get '/posts/new', to: 'posts#new'
  post '/posts', to: 'posts#create'
  get '/posts/:id', to: 'posts#show'

  get '/posts/:id/comments/new', to: 'comments#new'
  post '/posts/:id/comments', to: 'comments#create'
end
