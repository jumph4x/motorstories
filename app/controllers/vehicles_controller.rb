class VehiclesController < ApplicationController
  rescue_from MongoMapper::DocumentNotFound, :with => :render_404
  helper :navigation
  helper_method :authorized_to_edit?

  def index
    @vehicles = Vehicle.
      all_by_mmyn_slugs(*mmyn_slugs).
      claimed.
      limit(20).
      all
  end

  def show
    @vehicle = Vehicle.
      all_by_mmyn_slugs(*mmyn_slugs).
      first
    render_404 unless @vehicle
  end

  def new
    @proto_vehicle = load_proto_vehicle

    @vehicle = Vehicle.new
    @vehicle.proto_vehicle = @proto_vehicle
    @vehicle.prime!
  end

  def create
    @vehicle = Vehicle.new params[:vehicle]
    @vehicle.prime!

    if @vehicle.save
      handle_created_vehicle @vehicle
      redirect_to edit_vehicle_path(@vehicle, {:segment => 'poster'})
    else
      render :new
    end
  end

  def update
    @vehicle = Vehicle.find! params[:id]
    render_401 unless authorized_to_edit?

    if @vehicle.update_attributes(params[:vehicle])
      redirect_to semantic_vehicle_path(@vehicle.semantic_url_hash)
    else
      render :edit
    end
  end

  def edit
    @vehicle = Vehicle.find! params[:id]
    render_401 unless authorized_to_edit?
  end


  def authorized_to_edit?
    return unless @vehicle

    if current_user
      @vehicle.user_id == current_user.id
    else
      stored_vehicle_ids.include? @vehicle.id
    end
  end

  private

  def mmy_slugs
    [
      params[:make_slug],
      params[:model_slug],
      params[:year]
    ]
  end

  def mmyn_slugs
    mmy_slugs + [params[:nickname]]
  end

  def load_proto_vehicle
    ProtoVehicle.all_by_mmy_slugs(*mmy_slugs).first
  end
end
