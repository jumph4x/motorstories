module NavigationHelper
  def current_location
    return unless params[:location_slug]
    @location ||= Location.find_by_slug(params[:location_slug])
  end

  def current_make
    return unless params[:make_slug]
    @make ||= Make.find_by_slug(params[:make_slug])
  end

  def current_model
    return unless current_make
    @model ||= Model.find_by_make_id_and_slug(current_make.id, params[:model_slug])
  end

  def current_year
    @year ||= params[:year].try(:to_i) 
  end

  def make_dropdown
    collection = Make.car_or_motorcycle.map{|m| [m.name, m.name]}
    collection.unshift("Make", nil)
    select_tag :make, options_for_select(collection, current_make.try(:name))
  end

  def model_names_by_current_make
    current_make and Model.by_make_id(current_make.id).distinct(:name)
  end

  def model_dropdown
    collection = model_names_by_current_make || []
    html_hash = {}
    html_hash[:disabled] = 'disabled' if collection.present?
    collection.unshift("Model", nil)

    select_tag :model, options_for_select(collection, current_model.try(:name)), html_hash
  end

  def years_by_make_and_model
    current_make and current_model and
      BaseVehicle.years_by_make_id_and_model_id(current_make.id, current_model.id)
  end

  def year_dropdown
    collection = years_by_make_and_model || []
    html_hash = {}
    html_hash[:disabled] = 'disabled' if collection.present?
    collection.unshift("Year", nil)

    select_tag(:year, options_for_select(collection, params[:year]), html_hash)
  end
end
