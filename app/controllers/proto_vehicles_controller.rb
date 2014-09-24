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
    proto_vehicles = ProtoVehicle.model_names_by_make(make_name)

    respond_to do |format|
      format.json{ render :json => proto_vehicles }
    end
  end

  def year_index
    proto_vehicles = ProtoVehicle.years_by_make_and_model(make_name, model_name)

    respond_to do |format|
      format.json{ render :json => proto_vehicles }
    end
  end

  private

  def proto_params
    params.slice(:make, :model)
  end

  def sort_options
    return [:year, :desc] if params[:model]
    [:model, :asc]
  end
end

