Rails.application.routes.draw do

  # signup/login/logout/auto-login
  post '/signup', to: 'users#create'
  get '/me', to: 'users#show'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # recipe list
  resources :recipes, only: [:index, :create]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
