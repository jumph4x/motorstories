class RedirectsController < ApplicationController

  def vehicles_index
    if params[:make].present?
      redirect_to semantic_vehicles_path(url_params)
    else
      redirect_to search_path(name_params)
    end
  end

  def base_params
    params.except(:commit, :utf8)
  end

  def no_mm_params
    base_params.except(:make, :model)
  end

  def url_params
    h = no_mm_params.select do |key, val|
      val.present?
    end

    params.slice(:make, :model).each do |k, v|
      h["#{k}_slug"] = v.to_url
    end
    h
  end

  def name_params
    base_params.select do |key, val|
      val.present?
    end
  end
end
