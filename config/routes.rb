DailyHarbinger::Application.routes.draw do

#  get "sessions/new"

#  get "users/new"
#  get "users/show"

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]

  match '/signout', :to => 'sessions#destroy'
  match '/signin', :to => 'sessions#new'
  match '/signup', :to => 'users#new'
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  
  root :to => 'pages#home'

end
