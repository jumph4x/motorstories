class Vehicle
  include MongoMapper::Document

  before_create :set_location_from_profile
  before_validation :set_nickname_from_profile

  scope :claimed, where(:profile_id.ne => nil)
  scope :unclaimed, where(:profile_id => nil)

  belongs_to :base_vehicle
  belongs_to :profile

  key :make, String, :required => true
  key :model, String, :required => true
  key :year, Integer, :required => true

  key :nickname, String
  key :location_id, Integer

  validate :ensure_nickname_presence

  def location
    location_id && Location.find_by_id(location_id)
  end

  private

  def set_location_from_profile
    return true unless profile

    self.location_id = profile.location_id
  end

  def set_nickname_from_profile
    return true unless profile
    
    self.nickname ||= "#{profile.username}s-#{model.to_url}"
  end

  def ensure_nickname_presence
    return true unless profile

    errors.add(:nickname, "Add a nickname for your car") unless nickname.present?
  end

  # Exterior & Body
  # Brakes
  # Suspension
  # Engine
  # Drivetrain
  # Wheels
end
