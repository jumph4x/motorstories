class VehiclesController < ApplicationController

  def index
    @vehicles = Vehicle.where(vehicle_query_conditions).limit(20).all
  end

  def show
    @vehicle = Vehicle.where(vehicle_query_conditions).first
  end

  private

  def vehicle_query_conditions
    hash = {
      :location_id => current_location.id,
      :make => current_make.name
    }

    hash[:model] = current_model.name if current_model
    hash[:year] = params[:year].to_i if params[:year].present?
    hash[:nickname] = params[:nickname] if params[:nickname].present?
    
    hash
  end
end
