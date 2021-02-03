Rails.application.routes.draw do

  get '/companies', to:'companies#index'
  get '/companySort/contry', to:'companySort#show' 
  # get '/companies/:id', to:'companies#show'
  post '/companies', to:'companies#create'
  delete '/companies/:id', to:'companies#delete'
  put '/companies/:id', to:'companies#update'
  get '/filter/country', to:'companies#filterCountry'

  get '/cars', to:'cars#index'
  get '/singleCar/:id', to:'cars#showSingle'
  get '/cars/:id', to:'cars#show'
  post '/cars', to:'cars#create'
  delete '/cars/:id', to:'cars#delete'
  put '/cars/:id', to:'cars#update'
  # Filter routes
  get '/filter/type/:id/:type', to:'cars#filterType'
  #Filter country
end
