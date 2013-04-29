Motorstories::Application.routes.draw do

  resources :profiles, :path => 'people'
  resources :vehicles, :path => 'projects', :except => [:show, :index]

  LOCATION_IDS ||= /#{Location.pluck(:slug).join('|')}/

  match ':location_id/:make_id/:model_id/:year/:nickname' => 'vehicles#index', :location_id => LOCATION_IDS, :trailing_slash => true
  match ':location_id/:make_id(/:model_id(/:year))' => 'vehicles#index', :location_id => LOCATION_IDS, :trailing_slash => true
  match ':location_id' => 'locations#show', :location_id => LOCATION_IDS

  devise_for :users
  root :to => 'static#index'

end
