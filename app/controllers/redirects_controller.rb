class RedirectsController < ApplicationController

  def vehicles_index
    mmy = params.slice(:make_slug, :model_slug, :year)
    target = if (location = session[:location])
      vehicles_path(mmy.merge(:location_slug => location))
    else
      vehicles_path(mmy.merge(:location_slug => 'all'))
    end

    redirect_to target
  end
end
