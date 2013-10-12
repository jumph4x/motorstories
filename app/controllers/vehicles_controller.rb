class VehiclesController < ApplicationController
  rescue_from MongoMapper::DocumentNotFound, :with => :render_404
  helper :navigation

  def index
    @vehicles = Vehicle.where(vehicle_query_conditions).limit(20).all
  end

  def show
    @vehicle = Vehicle.where(vehicle_query_conditions).first
  end

  def new
    @base_vehicle = load_base_vehicle

    @vehicle = Vehicle.new
    @vehicle.base_vehicle = @base_vehicle
    @vehicle.prime!
  end

  def create
    @vehicle = Vehicle.new params[:vehicle]
    @vehicle.prime!

    if @vehicle.save
      redirect_to semantic_vehicle_path(@vehicle.semantic_url_hash)
    else
      render :new
    end
  end

  def edit
    @vehicle = Vehicle.where(vehicle_query_conditions).first
    segment = params[:segment].presence || :all
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

  def load_base_vehicle
    year = params[:year].try(:to_i)
    BaseVehicle.find_by_make_id_and_model_id_and_year!(current_make.try(:_id), current_model.try(:_id), current_year)
  end
end
