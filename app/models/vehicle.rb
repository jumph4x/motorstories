class Vehicle
  include MongoMapper::Document

  before_create :set_location_from_profile
  before_validation :set_nickname_from_profile, :set_vehicle_type

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
  key :spring_rear, String
  key :dampers_front, String
  key :dampers_rear, String
  key :camber_front, Float
  key :camber_rear, Float

  # Drivetrain
  key :front_sprocket, String
  key :front_sprocket_diff, Integer
  key :rear_sprocket, String
  key :rear_sprocket_diff, Integer
  key :chain, String
  key :chain_pitch, Integer

  key :transmission, String
  key :differential_ratio, String
  key :differential_lock, String

  # Brakes
  key :front_brake_diameter, Integer
  key :front_rotor, String
  key :front_caliper, String
  key :front_brake_pads, String
  key :front_brake_lines, String

  key :rear_brake_diamter, Integer
  key :rear_rotor, String
  key :rear_caliper, String
  key :rear_brake_pads, String
  key :rear_brake_lines, String

  # Wheels
  key :front_wheel, String
  key :front_wheel_dimater, Integer
  key :front_wheel_width, Float
  key :front_tire, String
  key :front_tire_width, Integer
  key :front_tire_profile, Integer

  key :rear_wheel, String
  key :rear_wheel_dimater, Integer
  key :rear_wheel_width, Float
  key :rear_tire, String
  key :rear_tire_width, Integer
  key :rear_tire_profile, Integer

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

  key :front_bumper, String
  key :rear_bumper, String
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
    set_nickname_from_profile
    set_name_from_base_vehicle
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

  def set_nickname_from_profile
    return true unless profile
    
    self.nickname ||= "#{profile.username}s-#{model.to_url}"
  end

  def ensure_nickname_presence
    return true unless profile

    errors.add(:nickname, "Add a nickname for your car") unless nickname.present?
  end

end
