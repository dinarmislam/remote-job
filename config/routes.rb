Rails.application.routes.draw do

  resources :jobs, :only => [:show, :new, :create]
  resources :categories, :only => [:show, :index]
  root 'categories#index'
  get 'search', to: 'search#search'
  get 'jobs' => 'categories#jobs'
end
