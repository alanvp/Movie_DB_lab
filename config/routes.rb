Movies::Application.routes.draw do

  get '/movies/search' => 'movies#search', as: :search

  resources :movies

  root 'movies#index'

  post '/movies/search' => 'movies#retrieve'



#      root GET    /                          movies#index
#     movies GET    /movies(.:format)          movies#index
#            POST   /movies(.:format)          movies#create
#  new_movie GET    /movies/new(.:format)      movies#new
# edit_movie GET    /movies/:id/edit(.:format) movies#edit
#      movie GET    /movies/:id(.:format)      movies#show
#            PATCH  /movies/:id(.:format)      movies#update
#            PUT    /movies/:id(.:format)      movies#update
#            DELETE /movies/:id(.:format)      movies#destroy




end
