class EntriesController < ApplicationController
  rescue_from MongoMapper::DocumentNotFound, :with => :render_404
  helper :navigation
  before_filter :load_vehicle
  before_filter :load_entry, :only => [:edit, :update]

  def new
  end

  def edit
  end

  def create
  end

  def update
    if @entry.update_attributes(entry_params)
      redirect_to semantic_vehicle_path(@vehicle.semantic_url_hash)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def entry_params
    params[:entry].permit(:snapshot, :body, :category, :occurred_at)
  end

  def load_entry
    @entry = @vehicle.entries.find(params[:id])
  end

  def load_vehicle
    @vehicle = Vehicle.find!(params[:vehicle_id])
  end

end
