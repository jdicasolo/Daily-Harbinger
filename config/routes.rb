DailyHarbinger::Application.routes.draw do

  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  
  root :to => 'pages#home'

end
