class YearsController < ApplicationController
  def index
    make = Make.find_by_slug(params[:make_slug])
    model = Model.find_by_make_id_and_slug(make.id, params[:model_slug])
    years = BaseVehicle.years_by_make_id_and_model_id(make.id, model.id)

    respond_to do |format|
      format.json{ render :json => years.map{|y| [y, y]} }
    end
  end
end
