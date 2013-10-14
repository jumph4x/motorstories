class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :navigation
  include NavigationHelper

  helper_method :stored_vehicle_ids, :stored_vehicles

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
end
