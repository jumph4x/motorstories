class VehiclesController < ApplicationController
  rescue_from MongoMapper::DocumentNotFound, :with => :render_404
  helper :navigation
  helper_method :authorized_to_edit?, :collection, :filtered?

  def index
    respond_to do |format|
      format.html do
        #render (filtered? ? 'index' : 'search_help')
      end
    end
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
      redirect_to edit_vehicle_path(@vehicle, {:segment => 'mod_survey'})
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

  def collection
    @vehicles ||=
    if filtered?
      Vehicle.
      all_by_mmyn_slugs(*mmyn_slugs).
      by_type(params[:vehicle_type]).
      with_keywords(params[:keywords]).
      claimed.
      limit(20).
      all
    else
      []
    end
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

  def filtered?
    mmy_slugs.compact.present? || [params[:keywords], params[:vehicle_type]].compact.present?
  end

  def mmyn_slugs
    mmy_slugs + [params[:nickname]]
  end

  def load_proto_vehicle
    pv = ProtoVehicle.all_by_mmy_slugs(*mmy_slugs).first
    render_404 unless pv
    pv
  end
end
