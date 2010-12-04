DailyHarbinger::Application.routes.draw do

  get "users/new"

  match '/signup', :to => 'users#new'

  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  
  root :to => 'pages#home'

end
