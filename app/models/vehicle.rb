class Vehicle
  include MongoMapper::Document

  scope :claimed, where(:profile_id.ne => nil)
  scope :unclaimed, where(:profile_id => nil)

  belongs_to :base_vehicle
  belongs_to :profile

  key :make, String, :required => true
  key :model, String, :required => true
  key :year, Integer, :required => true
end
