Motorstories::Application.routes.draw do

  resources :profiles, :path => 'people'

  devise_for :users

  root :to => 'static#index'

end
