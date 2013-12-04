class RedirectsController < ApplicationController

  def vehicles_index
    redirect_to semantic_vehicles_path(mmy_params)
  end

  def mmy_params
    h = {}
    params.slice(:make, :model).each do |k, v|
      h["#{k}_slug"] = v.to_url
    end
    h[:year] = params[:year] if params[:year]
    h
  end
end
