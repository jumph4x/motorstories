class ProtoVehiclesController < ApplicationController
  def index
    proto_vehicles = if proto_params
      ProtoVehicle.where(proto_params).sort(sort_options).all
    else
      []
    end

    respond_to do |format|
      format.json{ render :json => proto_vehicles }
    end
  end

  def model_index
    proto_vehicles = ProtoVehicle.distinct_collection

    respond_to do |format|
      format.json{ render :json => proto_vehicles }
    end
  end

  def year_index

  end

  private

  def proto_params
    params.slice(:make, :model)
  end

  def sort_options
    return [:year, :desc] if params[:model]
    [:model, :asc]
  end

  def field_to_load
    if params[:model]
      :year
    else
      :model
    end
  end
end

