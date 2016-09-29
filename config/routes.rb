Rails.application.routes.draw do 

  resources :jobs, :only => [:show, :new, :create]
  resources :categories, :only => [:show, :index]
  root 'categories#index'

end
