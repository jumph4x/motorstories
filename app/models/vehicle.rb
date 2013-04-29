class Vehicle
  include MongoMapper::Document

  before_create :set_location_from_profile

  scope :claimed, where(:profile_id.ne => nil)
  scope :unclaimed, where(:profile_id => nil)

  belongs_to :base_vehicle
  belongs_to :profile

  key :make, String, :required => true
  key :model, String, :required => true
  key :year, Integer, :required => true

  key :location_id, Integer

  def location
    location_id && Location.find_by_id(location_id)
  end

  private

  def set_location_from_profile
    return true unless profile

    self.location_id = profile.location_id
  end
end
