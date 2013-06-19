class BaseVehicle
  include MongoMapper::Document

  belongs_to :make
  belongs_to :model

  key :year, Integer

  def vehicle_type
    model.vehicle_type.name
  end

  class << self
    def years_by_make_id_and_model_id make_id, model_id
      BaseVehicle.where(:make_id => make_id, :model_id => model_id).distinct(:year)
    end
  end
end
