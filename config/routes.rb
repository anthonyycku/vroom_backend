Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/companies', to:'companies#index'
  get '/companySort/contry', to:'companySort#show' 
  # get '/companies/:id', to:'companies#show'
  post '/companies', to:'companies#create'
  delete '/companies/:id', to:'companies#delete'
  put '/companies/:id', to:'companies#update'

  get '/cars', to:'cars#index'
  get '/cars/:id', to:'cars#show'
  post '/cars', to:'cars#create'
  delete '/cars/:id', to:'cars#delete'
  put '/cars/:id', to:'cars#update'
  end
