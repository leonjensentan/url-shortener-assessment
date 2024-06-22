Rails.application.routes.draw do
  
  resources :urls, only: [:create]
  #This route maps to the 'show' action in the 'UrlsController'
  #':short_url' is a dynamic segment that captures the short URL
  get '/:short_url/show', to: 'urls#show', as: "url"

  #This route maps to the 'redirect' action in the 'UrlsController'
  get '/:short_url', to: 'urls#redirect'

  #Root Path
  root 'urls#new'
end
