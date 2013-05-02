Motorstories::Application.routes.draw do

  resources :profiles, :path => 'people'
  resources :vehicles, :path => 'projects', :except => [:show, :index]
  resources :models, :only => :index
  resources :years, :only => :index

  location_slugs = /#{Location.pluck(:slug).join('|')}/

  match ':location_slug/:make_slug/:model_slug/:year/:nickname' => 'vehicles#show', :location_slug => location_slugs
  match ':location_slug/:make_slug(/:model_slug(/:year))' => 'vehicles#index', :location_slug => location_slugs, :trailing_slash => true
  match ':location_slug' => 'locations#show', :location_slug => location_slugs

  devise_for :users
  root :to => 'static#index'

end
