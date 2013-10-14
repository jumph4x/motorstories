class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :navigation
  include NavigationHelper

  helper_method :stored_vehicle_ids, :stored_vehicles
  after_filter :store_location

  def render_404
    redirect_to '/'
  end

  def store_created_vehicle vehicle
    return unless vehicle
    session[:vehicles] ||= []
    session[:vehicles] << vehicle.id
  end

  def stored_vehicle_ids
    session[:vehicles] || []
  end

  def stored_vehicles
    @cached_stored_vehicles ||= Vehicle.where(:id => stored_vehicle_ids).all
  end

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return if request.fullpath.match(/users|sign_in|sign_up|password/) || request.xhr?
    session[:previous_url] = request.fullpath 
  end

  def after_sign_in_path_for(resource)
    puts session.inspect
    session[:previous_url] || root_path
  end
end
