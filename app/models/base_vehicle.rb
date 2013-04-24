class BaseVehicle
  include MongoMapper::Document

  belongs_to :make
  belongs_to :model

  key :year, Integer
end
