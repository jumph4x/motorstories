class Vehicle
  require 'carrierwave/orm/mongomapper'
  include MongoMapper::Document

  VEHICLE_TYPE_GROUPS = {
    'Car'                => :car,
    'Truck'              => :car,
    'Van'                => :car,
    'Offroad Motorcycle' => :motorcycle,
    'Street Motorcycle'  => :motorcycle
  }

  mount_uploader :cover, CoverUploader

  before_validation :set_proto_vehicle, :set_vehicle_type, :set_nickname

  scope :claimed, where(:user_id.ne => nil)
  scope :unclaimed, where(:user_id => nil)

  belongs_to :proto_vehicle
  belongs_to :user

  validate :ensure_nickname_presence
  validates :nickname, :uniqueness => true
  validates :cover, :presence => true

  key :make, String, :required => true
  key :model, String, :required => true
  key :year, Integer, :required => true
  key :vehicle_type, String, :required => true

  key :nickname, String

  def self.mod_categories
    [:motor, :suspension, :drivetrain, :brakes, :ergonomics, :body]
  end

  attr_accessor :motor_modded
  attr_accessor :suspension_modded
  attr_accessor :drivetrain_modded
  attr_accessor :brakes_modded
  attr_accessor :ergonomics_modded
  attr_accessor :body_modded

  # Motor
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

  # Ergonomics
  key :control_levers, String
  key :steering_damper, String
  key :gauges, String
  key :rear_sets, String
  key :seat, String
  key :rollcage, String
  key :steering_wheel, String
  key :pedals, String

  # Body
  key :headlight, String
  key :crash_cage, String # or sliders
  key :plastics, String

  key :bumper_front, String
  key :bumper_rear, String
  key :spoiler, String
  key :hood, String
  key :trunk, String
  key :tint, String

  class << self
    def all_by_mmyn_slugs make_slug, model_slug, year, nickname
      query = Motorstories::SlugCache.query_hash_from_mmyn_slugs make_slug, model_slug, year, nickname
      where(query)
    end
  end

  def name
    "#{year} #{make} #{model}"
  end

  def short_name
    "'#{year.to_s[2..3]} #{model}"
  end

  def group
    VEHICLE_TYPE_GROUPS[vehicle_type]
  end

  def make_slug
    make.to_url
  end

  def model_slug
    model.to_url
  end

  def prime!
    #set_location_from_user
    set_proto_vehicle
    set_vehicle_type
    set_nickname
    set_name_from_proto_vehicle
  end

  def semantic_url_hash
    {
      :make_slug => make_slug,
      :model_slug => model_slug,
      :year => year, 
      :nickname => nickname
    }
  end

  def claimed?
    user_id.present?
  end

  private

  def set_name_from_proto_vehicle
    return true unless proto_vehicle

    self.year = proto_vehicle.year
    self.make = proto_vehicle.make
    self.model = proto_vehicle.model
  end

  #def set_location_from_user
  #  return true unless user
  #end

  def set_proto_vehicle
    return true unless make && model && year

    self.proto_vehicle = ProtoVehicle.first_by_mmy make, model, year
  end

  def set_vehicle_type
    return true unless proto_vehicle

    self.vehicle_type = proto_vehicle.vehicle_type
  end

  def set_nickname
    self.nickname = nil if user_id_changed?
    if user
      self.nickname ||= "#{user.username}s-#{model.to_url}"
    else
      self.nickname ||= _id
    end
  end

  def ensure_nickname_presence
    return true unless user

    errors.add(:nickname, "Add a nickname for your car") unless nickname.present?
  end

end
