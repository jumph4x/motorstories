module NavigationHelper
  def current_year
    @year ||= params[:year].try(:to_i) 
  end

  def current_mmy
    mmy = params.slice(:make_slug, :model_slug, :year)
    mmy.size == 3 and mmy.values.all?{|p| p.present?} and mmy
  end

  def make_dropdown
    collection = ProtoVehicle.make_names
    select_tag :make, options_for_select(([['Make', nil]] + collection ), make_name)
  end

  def make_name
    params[:make_slug] && Motorstories::SlugCache.make_query(params[:make_slug])
  end

  def model_name
    params[:model_slug] && Motorstories::SlugCache.model_query(params[:model_slug])
  end

  def model_names_by_current_make
    ProtoVehicle.model_names_by_make(make_name)
  end

  def model_dropdown
    collection = model_names_by_current_make
    html_hash = {}
    html_hash[:disabled] = 'disabled' unless collection.present?
    collection.unshift(["Model", nil])

    select_tag :model, options_for_select(collection, model_name), html_hash
  end

  def years_by_make_and_model
    ProtoVehicle.years_by_make_and_model(make_name, model_name)
  end

  def year_dropdown
    collection = years_by_make_and_model
    html_hash = {}
    html_hash[:disabled] = 'disabled' unless collection.present?
    collection.unshift(["Year", nil])

    select_tag(:year, options_for_select(collection, params[:year]), html_hash)
  end

  def mmy_selector redirect = false
    clazz = 'mmy-selector'
    output = make_dropdown +
             model_dropdown +
             year_dropdown

    if redirect
      output += content_tag(:a, 'Browse', {id: 'mmy-submit', class: 'button'})
      clazz += ' redirectable'
    end

    content_tag(:div, class: clazz) do
      output
    end
  end
end
