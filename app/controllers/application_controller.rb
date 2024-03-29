class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :navigation
  include NavigationHelper

  helper_method :stored_vehicle_ids, :stored_vehicles,
                :current_location, :user_vehicles,
                :make_name, :model_name

  after_filter :store_location
  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_404
    flash[:error] = 'Oops, page not found.'
    redirect_to '/'
  end

  def current_location
    "#{controller_name}-#{action_name}"
  end

  def render_401
    flash[:error] = "Try not to do that. Your account has been flagged."
    redirect_to '/'
  end

  def handle_created_vehicle vehicle
    return unless vehicle
    if current_user
      vehicle.set(:user_id => current_user.id)
    else
      session[:vehicles] ||= []
      session[:vehicles] << vehicle.id
    end
  end

  def stored_vehicle_ids
    session[:vehicles] || []
  end

  def wipe_stored_vehicles
    session.delete :vehicles
  end

  def stored_vehicles
    @cached_stored_vehicles ||= Vehicle.where(:id => stored_vehicle_ids).all
  end

  def user_vehicles
    if current_user
      current_user.vehicles
    else
      stored_vehicles
    end
  end

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return if request.fullpath.match(/users|sign_in|sign_up|password/) || request.xhr?
    return unless request.get?

    session[:previous_url] = request.fullpath 
  end

  def after_sign_in_path_for(resource)
    stored_vehicles.each do |vehicle|
      vehicle.set(:user_id => current_user.id)
    end
    wipe_stored_vehicles

    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    session[:previous_url] || root_path
  end

  def make_name
    params[:make] || (params[:make_slug] && Motorstories::SlugCache.make_query(params[:make_slug]))
  end

  def model_name
    params[:model] || (params[:model_slug] && Motorstories::SlugCache.model_query(params[:model_slug]))
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :email
  end
end
