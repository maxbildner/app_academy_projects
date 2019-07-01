Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :users
  get '/users' => 'users#index'                 # we don't need ID here either because it displays everyone
  post '/users' => 'users#create'               # we don't need ID here because we are just creating a new one
  get '/users/:id' => 'users#show'              # we need ID here because we need to grab a specific user who's already in the database (referencing something that already exists in DB)
  patch '/users/:id' => 'users#update'  
  delete '/users/:id' => 'users#destroy'       # we need ID here because we are only destroying one thing  
end
