class Vehicle
  include MongoMapper::Document

  scope :claimed, where(:user_id.ne => nil)
  scope :unclaimed, where(:user_id => nil)

  belongs_to :base_vehicle
  belongs_to :user

  key :make, String, :required => true
  key :model, String, :required => true
  key :year, Integer, :required => true
end
