class Model
  include MongoMapper::Document

  has_many :base_vehicles

  key :name, String
  key :vehicle_type_id, Integer
  # designates the chassis type
  # 5 car
  # 40 motorcycle

  ACES_VEHICLE_TYPE_MAP = {
    5  => 'car',
    40 => 'motorcycle'
  }

  def vehicle_type
    ACES_VEHICLE_TYPE_MAP[vehicle_type_id] 
  end
end
