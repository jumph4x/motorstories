Motorstories::Application.routes.draw do

  devise_for :users

  resources :profiles, :path => 'people'
  resources :proto_vehicles do
    collection do
      get :model_index
      get :year_index
    end
  end

  resources :vehicles, :path => 'projects', :except => [:show, :index] do
    resources :entries, :except => [:index, :show] do
      member do
        get :photo_editor
        get :photo_update
        post :photo_update
      end
    end
  end
  resources :models, :only => :index
  resources :years, :only => :index

  get 'redirects/vehicles_index' => 'redirects#vehicles_index'

  get ':make_slug/:model_slug/:year/:nickname' => 'vehicles#show',
    :as => 'semantic_vehicle'

  get ':make_slug(/:model_slug(/:year))' => 'vehicles#index',
    :trailing_slash => true,
    :as => 'semantic_vehicles'

  #get ':location_slug' => 'locations#show',:as => 'locations'

  root :to => 'static#index'

end
