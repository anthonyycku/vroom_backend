Rails.application.routes.draw do

  get '/companies', to: 'companies#index'
  get '/companies/:id', to: 'companies#show'
  post '/companies', to: 'companies#create'
  put '/companies/:id', to: 'companies#update'
  delete '/companies/:id', to: 'companies#delete'
  get '/filter/country', to:'companies#filterCountry'
  get '/filter/countryDesc', to:'companies#filterCountryDesc'
  get '/filter/alphabeticalASC', to:'companies#alphabeticalASC'
  get '/filter/alphabeticalDesc', to:'companies#alphabeticalDesc'
  # 
  get '/filter/countcarsASC', to:'companies#countcarsASC'
  get '/filter/countcarsDESC', to:'companies#countcarsDESC'

  get '/cars', to:'cars#index'
  get '/singleCar/:id', to:'cars#showSingle'
  get '/cars/:id', to:'cars#show'
  post '/cars', to:'cars#create'
  delete '/cars/:id', to:'cars#delete'
  put '/cars/:id', to:'cars#update'
  # Filter routes
  get '/filter/type/:id/:type', to:'cars#filterType'


end
