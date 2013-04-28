Motorstories::Application.routes.draw do

  resources :profiles


  devise_for :users

  root :to => 'static#index'

end
