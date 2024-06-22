Rails.application.routes.draw do
  
  resources :urls, only: [:create]
  get '/:short_url/show', to: 'urls#show', as: "url"
  get '/:short_url', to: 'urls#redirect'
  root 'urls#new'
end
