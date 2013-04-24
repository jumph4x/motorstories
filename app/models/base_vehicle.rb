class BaseVehicle
  include MongoMapper::Document

  belongs_to :make
  belongs_to :model

  key :year, Integer
  #key :make_id, Integer
  #key :model_id, Integer

end
