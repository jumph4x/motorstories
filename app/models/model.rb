class Model
  include MongoMapper::Document

  has_many :base_vehicles

  key :name, String
  key :vehicle_type_id, Integer

  def vehicle_type
    vehicle_type_id && VehicleType.find_by_id(vehicle_type_id)
  end

  def chassis_type
    vehicle_type && vehicle_type.name
  end
end
