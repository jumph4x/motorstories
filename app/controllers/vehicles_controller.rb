class VehiclesController < ApplicationController
  helper :navigation

  def index
    @vehicles = Vehicle.where(vehicle_query_conditions).limit(20).all
  end

  def show
    @vehicle = Vehicle.where(vehicle_query_conditions).first
  end

  def new
   base_vehicle = BaseVehicle.where(vehicle_query_conditions.slice(:make, :model, :year)).first
   (redirect_to('/') && return) unless base_vehicle

   @vehicle = Vehicle.new
   @vehicle.base_vehicle = base_vehicle
   @vehicle.prime!
  end

  private

  def vehicle_query_conditions
    hash = {}

    hash[:make] = current_make.name if current_make
    hash[:model] = current_model.name if current_model
    hash[:year] = params[:year].to_i if params[:year].present?

    hash[:location_id] = current_location.id if current_location
    hash[:nickname] = params[:nickname] if params[:nickname].present?
    
    hash
  end
end
