Motorstories::Application.routes.draw do

  resources :profiles, :path => 'people'
  resources :vehicles

  devise_for :users

  root :to => 'static#index'

end
