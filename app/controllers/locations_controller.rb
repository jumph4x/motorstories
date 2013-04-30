class LocationsController < ApplicationController

  def show
    @location = Location.find_by_slug(params[:location_slug]) 
  end
end
