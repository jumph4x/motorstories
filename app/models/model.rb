class Model
  include MongoMapper::Document

  has_many :base_vehicles

  key :name, String
  key :vehicle_type_id, Integer

  scope :car_or_motorcycle, where(:vehicle_type_id => [4,5,6,7,40])

  def vehicle_type
    vehicle_type_id && VehicleType.find_by_id(vehicle_type_id)
  end

  def chassis_type
    vehicle_type && vehicle_type.name
  end

  class << self
    def by_make_id make_id
      model_ids = BaseVehicle.where(:make_id => make_id).distinct(:model_id)
      car_or_motorcycle.where(:_id => model_ids)
    end
  end
end
