class EntriesController < ApplicationController
  rescue_from MongoMapper::DocumentNotFound, :with => :render_404
  helper :navigation
  before_filter :load_vehicle
  before_filter :load_entry, :only => [:edit, :update, :photo_editor, :photo_update]

  def new
  end

  def edit
  end

  def photo_editor
  end

  def create
  end

  def update
    if @entry.update_attributes(entry_params)
      if params[:commit].match(/photo/i)
        redirect_to photo_editor_vehicle_entry_path(@vehicle, @entry)
      else
        redirect_to semantic_vehicle_path(@vehicle.semantic_url_hash)
      end
    else
      render :edit
    end
  end

  def photo_update
    return unless params[:url]

    @entry.remote_snapshot_url = params[:url]
    @entry.save

    render :nothing => true
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
