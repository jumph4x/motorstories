class VehiclesController < ApplicationController
  before_filter :load_location, :load_make, :load_modell, :only => [:index, :show]

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

    hash[:model] = current_modell.name if current_modell
    hash[:year] = params[:year].to_i if params[:year].present?
    hash[:nickname] = params[:nickname] if params[:nickname].present?
    
    hash
  end

  def load_location
    @location ||= Location.find_by_slug(params[:location_slug])
  end
  alias current_location load_location

  def load_make
    @make ||= Make.find_by_slug(params[:make_slug])
  end
  alias current_make load_make

  def load_modell
    return unless current_make
    @model ||= Model.find_by_make_id_and_slug(current_make.id, params[:model_slug])
  end
  alias current_modell load_modell
end
