class Vehicle
  include MongoMapper::Document

  before_create :set_location_from_profile
  before_validation :set_nickname, :set_vehicle_type

  scope :claimed, where(:profile_id.ne => nil)
  scope :unclaimed, where(:profile_id => nil)

  belongs_to :base_vehicle
  belongs_to :profile

  validate :ensure_nickname_presence
  validates :nickname, :uniqueness => true

  key :make, String, :required => true
  key :model, String, :required => true
  key :year, Integer, :required => true
  key :vehicle_type, String, :required => true

  key :nickname, String
  key :location_id, Integer

  # General
  key :acquired_at, Date
  key :project_type, String

  # Engine
  key :exhaust, String
  key :intake, String
  key :engine_management, String
  key :engine_code, String

  # Suspension
  key :height_diff, Float
  key :springs_front, String
  key :springs_rear, String
  key :dampers_front, String
  key :dampers_rear, String

  key :camber_front, Float
  key :camber_rear, Float

  # Drivetrain
  key :sprocket_front, String
  key :sprocket_front_diff, Integer
  key :sprocket_rear, String
  key :sprocket_rear_diff, Integer
  key :chain, String
  key :chain_pitch, Integer

  key :transmission, String
  key :differential_ratio, String
  key :differential_lock, String

  # Brakes
  key :brake_front_diameter, Integer
  key :rotor_front, String
  key :caliper_front, String
  key :brake_front_pads, String
  key :brake_front_lines, String

  key :brake_rear_diameter, Integer
  key :rotor_rear, String
  key :caliper_rear, String
  key :brake_rear_pads, String
  key :brake_rear_lines, String

  # Wheels
  key :wheel_front, String
  key :wheel_front_diameter, Integer
  key :wheel_front_width, Float
  key :tire_front, String
  key :tire_front_width, Integer
  key :tire_front_profile, Integer

  key :wheel_rear, String
  key :wheel_rear_diameter, Integer
  key :wheel_rear_width, Float
  key :tire_rear, String
  key :tire_rear_width, Integer
  key :tire_rear_profile, Integer

  # Controls & Interior
  key :control_levers, String
  key :steering_damper, String
  key :gauges, String
  key :rear_sets, String
  key :seat, String
  key :rollcage, String
  key :steering_wheel, String
  key :pedals, String

  # Exterior & Body
  key :headlight, String
  key :crash_cage, String # or sliders
  key :plastics, String

  key :bumper_front, String
  key :bumper_rear, String
  key :spoiler, String
  key :hood, String
  key :trunk, String
  key :tint, String

  def name
    "#{year} #{make} #{model}"
  end

  def make_slug
    make.to_url
  end

  def model_slug
    model.to_url
  end

  def location
    location_id && Location.find_by_id(location_id)
  end

  def prime!
    set_location_from_profile
    set_vehicle_type
    set_nickname
    set_name_from_base_vehicle
  end

  def semantic_url_hash
    {
      :make_slug => make_slug,
      :model_slug => model_slug,
      :year => year, 
      :nickname => nickname
    }
  end

  private

  def set_name_from_base_vehicle
    return true unless base_vehicle

    self.year = base_vehicle.year
    self.make = base_vehicle.make.name
    self.model = base_vehicle.model.name
  end

  def set_location_from_profile
    return true unless profile

    self.location_id = profile.location_id
  end

  def set_vehicle_type
    return true unless base_vehicle

    self.vehicle_type = base_vehicle.vehicle_type
  end

  def set_nickname
    self.nickname = nil if profile_id_changed?
    if profile
      self.nickname ||= "#{profile.username}s-#{model.to_url}"
    else
      self.nickname ||= _id
    end
  end

  def ensure_nickname_presence
    return true unless profile

    errors.add(:nickname, "Add a nickname for your car") unless nickname.present?
  end

end
