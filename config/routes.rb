Motorstories::Application.routes.draw do

  resources :profiles, :path => 'people'
  resources :vehicles, :path => 'projects', :except => [:show, :index]
  resources :models, :only => :index
  resources :years, :only => :index

  location_slugs = /#{Location.pluck(:slug).join('|')}/

  get 'redirects/vehicles_index' => 'redirects#vehicles_index'

  get ':location_slug/:make_slug/:model_slug/:year/:nickname' => 'vehicles#show',
    :location_slug => location_slugs,
    :as => 'semantic_vehicle'

  get ':location_slug/:make_slug(/:model_slug(/:year))' => 'vehicles#index',
    :location_slug => location_slugs,
    :trailing_slash => true,
    :as => 'semantic_vehicles'

  get ':location_slug' => 'locations#show',
    :location_slug => location_slugs,
    :as => 'locations'

  devise_for :users
  root :to => 'static#index'

end
