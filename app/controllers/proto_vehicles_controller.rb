class ProtoVehiclesController < ApplicationController
  def index
    proto_vehicles = if proto_params
      ProtoVehicle.where(proto_params).all
    else
      []
    end

    respond_to do |format|
      format.json{ render :json => proto_vehicles }
    end
  end

  private

  def proto_params
    params.slice(:make, :model)
  end
end

