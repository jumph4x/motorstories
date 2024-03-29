class ModelsController < ApplicationController
  def index
    make = Make.find_by_slug(params[:make_slug])
    models = Model.by_make_id make.id

    respond_to do |format|
      format.json{ render :json => models.map{|m| [m.name, m.name.to_url]} }
    end
  end
end
