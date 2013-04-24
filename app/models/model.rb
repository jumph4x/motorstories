class Model
  include MongoMapper::Document

  has_many :base_vehicles

  key :name, String
  key :vehicle_type_id, Integer
end
