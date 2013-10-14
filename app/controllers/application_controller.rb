class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :navigation
  include NavigationHelper

  after_filter :store_location

  def render_404
    redirect_to '/'
  end


  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return if request.fullpath.match(/users|sign_in|sign_up|password/) || request.xhr?
    session[:previous_url] = request.fullpath 
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    session[:previous_url] || root_path
  end
end
