class Make
  include MongoMapper::Document

  has_many :base_vehicles

  key :name, String
end
