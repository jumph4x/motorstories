class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :navigation
  include NavigationHelper
end
