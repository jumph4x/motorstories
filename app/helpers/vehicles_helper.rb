module VehiclesHelper

  # project type helper
  SELECT_OPTIONS = {
    :car => {
      :project_type => ['autocross warrior', 'track attack', 'drifter', 'daily driver', 'offroader', 'hauler', 'vip']
    },
    :motorcycle => {
      :project_type => ['track attack', 'adventure', 'street fighter', 'commuter', 'stunter']
    }
  }
  def select_options_for vehicle_type, field, existing_value = nil
    options = SELECT_OPTIONS[vehicle_type.to_sym][field.to_sym]
    options_for_select(options, existing_value)
  end

  # fields specific to vehicle types
  SPECIFIC_SECTION_FIELDS = {
    :car => {
      :suspension => [:camber_front, :camber_rear],
      :drivetrain => [:transmission, :differential_ratio, :differential_lock],
      :wheels => [:front_wheel, :rear_wheel, :front_wheel_diameter,
                  :rear_wheel_diameter, :front_wheel_width, :rear_wheel_width],
      :controls_interior => [:rollcage, :steering_wheel, :pedals],
      :exterior_body => [:front_bumper, :rear_bumper, :hood, :trunk, :tint, :spoiler]
    },
    :motorcycle => {
      :drivetrain => [:front_sprocket, :front_sprocket_diff, :rear_sprocket, :rear_sprocket_diff, :chain, :chain_pitch],
      :controls_interior => [:control_levers, :steering_damper, :rear_sets],
      :exterior_body => [:crash_cage, :plastics]
    }
  }
  # fields shared by both vehicle types
  SECTION_FIELDS = {
    :general => [:acquired_at, :project_type],
    :suspension => [:height_diff, :springs_front, :springs_rear, :dampers_front, :dampers_rear],
    :engine => [:intake, :exhaust, :engine_management, :engine_code],
    :brakes => [:front_brake_diameter, :rear_brake_diameter, :front_rotor, :rear_rotor, :front_caliper,
                :rear_caliper, :front_brake_lines, :rear_brake_lines, :front_brake_pads, :rear_brake_pads],
    :wheels => [:front_tire, :rear_tire, :front_tire_width, :rear_tire_width, :front_tire_profile, :rear_tire_profile],
    :controls_interior => [:gauges, :seat],
    :exterior_body => [:headlight]
  }
  def section_fields vehicle_type, section
    (SECTION_FIELDS[section.to_sym] || []) +
    (SPECIFIC_SECTION_FIELDS[vehicle_type.to_sym][section.to_sym] || [])
  end

  def render_vehicle_field vehicle_type, attr, f
    if dropdown_field?(vehicle_type, attr)
      render_dropdown_field vehicle_type, attr, f
    else
      render_text_field attr, f
    end
  end

  def dropdown_field? vehicle_type, attr
    s = SELECT_OPTIONS[vehicle_type.to_sym] and
    s[attr.to_sym]
  end

  def render_dropdown_field vehicle_type, attr, f
    f.select(attr, select_options_for(vehicle_type, attr),{}, {:class => 'half space'})
  end

  def render_text_field attr, f
    output = f.text_field attr, :placeholder => t(attr, default: attr.to_s.humanize)
    output << content_tag(:span, t("units.#{attr}", :default => ''), :class => 'input-append-thing')
    output
  end

end
