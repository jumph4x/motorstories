class Vehicle
  include MongoMapper::Document

  before_create :set_location_from_profile
  before_validation :set_nickname_from_profile

  scope :claimed, where(:profile_id.ne => nil)
  scope :unclaimed, where(:profile_id => nil)

  belongs_to :base_vehicle
  belongs_to :profile

  validate :ensure_nickname_presence

  key :make, String, :required => true
  key :model, String, :required => true
  key :year, Integer, :required => true

  key :nickname, String
  key :location_id, Integer

  #DETAIL_FIELDS = {
  #  general: [
  #    [:acquired_at, Date],
  #    [:project_type, String]
  #  ],
  #  engine: [
  #    [:exhaust, String],
  #    [:intake, String],
  #    [:engine_management, String],
  #    [:engine_code, String, 0]
  #  ],
  #  suspension: [
  #    [:height_diff, Float],
  #    [:springs_front, String],
  #    [:spring_rear, String],
  #    [:dampers_front, String],
  #    [:dampers_rear, String],
  #    [:camber_front, Float, 0],
  #    [:camber_rear, Float, 0]
  #  ],
  #  drivetrain: [
  #    [:front_sprocket, String, 1],
  #    [:front_sprocket_diff, Integer, 1],
  #    [:rear_sprocket, String, 1],
  #    [:rear_sprocket_diff, Integer, 1],
  #    [:chain, String, 1],
  #    [:chain_pitch, Integer, 1],
  #    [:transmission, String],
  #    [:differential_ratio, String, 0],
  #    [:differential_lock, String, 0]
  #  ],
  #  brakes: [
  #    [:front_brake_diameter, Integer],
  #    [:front_rotor, String],
  #    [:front_caliper, String],
  #    [:front_brake_pads, String],
  #    [:front_brake_lines, String],
  #    [:rear_brake_diamter, Integer],
  #    [:rear_rotor, String],
  #    [:rear_caliper, String],
  #    [:rear_brake_pads, String],
  #    [:rear_brake_lines, String]
  #  ],
  #  wheels: [
  #    [:front_wheel, String, 0],
  #    [:front_wheel_dimater, Integer, 0],
  #    [:front_wheel_width, Float, 0],
  #    [:front_tire, String],
  #    [:front_tire_width, Integer],
  #    [:front_tire_profile, Integer, 0],
  #    [:rear_wheel, String, 0],
  #    [:rear_wheel_dimater, Integer, 0],
  #    [:rear_wheel_width, Float, 0],
  #    [:rear_tire, String],
  #    [:rear_tire_width, Integer],
  #    [:rear_tire_profile, Integer, 0]
  #  ],
  #  interior: [
  #    [:control_levers, String, 1],
  #    [:steering_damper, String, 1],
  #    [:gauges, String],
  #    [:rear_sets, String, 1],
  #    [:seat, String],
  #    [:rollcage, String],
  #    [:steering_wheel, String, 0],
  #    [:pedals, String, 0]
  #  ],
  #  body: [
  #    [:headlight, String],
  #    [:crash_cage, String, 1],# or sliders
  #    [:plastics, String, 1],
  #    [:front_bumper, String, 0],
  #    [:rear_bumper, String, 0],
  #    [:spoiler, String, 0],
  #    [:hood, String, 0],
  #    [:trunk, String, 0],
  #    [:tint, String, 0]
  #  ]
  #}

  #DETAIL_FIELDS.each do |group_name, fields|
  #  fields.each do |field_stuffs|
  #    field, data_type, applicability = field_stuffs
  #    key(field, data_type)
  #  end
  #end

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

  def make_slug
    make.to_url
  end

  def model_slug
    model.to_url
  end

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

end
