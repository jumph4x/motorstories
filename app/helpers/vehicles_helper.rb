module VehiclesHelper

  def name_from_params
    [params[:year], make_name, model_name].compact.join(' ')
  end

  def title_vehicles_show
    @vehicle.name
  end

  def vehicle_owner vehicle
    return unless vehicle.claimed? or stored_vehicle_ids.include? vehicle.id

    content_tag :div, class: 'owner' do
      if vehicle.claimed? 
        content_tag(:div, "Owner: #{link_to vehicle.user.username, profile_path(vehicle.user)}".html_safe, class: 'username') <<
        content_tag(:div, "Joined #{vehicle.user.created_at.strftime("%b %Y")}", class: 'joined')
      else
        content_tag(:div, "Owner: you! #{link_to "Register", new_user_registration_path}".html_safe, class: 'username') <<
        content_tag(:div, "Joined today", class: 'joined')
      end
    end
  end

  def vehicle_call_to_action vehicle
    return unless authorized_to_edit?

    content_tag :div, class: 'subhead' do
      if current_user
        "This is yours, looking good! #{next_step_for_vehicle vehicle}".html_safe
      else
        "Like what you see? Save your changes #{link_to "by registering", new_user_registration_path}. This project page won't be saved otherwise.".html_safe
      end
    end
  end

  def next_step_for_vehicle vehicle
    if vehicle.poster.blank?
      "Looks like the poster is missing. Want to #{link_to "add one", edit_vehicle_path(vehicle, :segment => :poster)}?"
    else
      "Did you install any new goodies? #{link_to "Update the spec", edit_vehicle_path(vehicle)}."
    end
  end

  def select_options_for vehicle_type, field, existing_value = nil
    options = select_options[vehicle_type.to_sym][field.to_sym]
    options_for_select(options, existing_value)
  end

  def fields vehicle_type, section
    (section_fields[section.to_sym] || []) +
    (specific_section_fields[vehicle_type.to_sym][section.to_sym] || [])
  end

  def render_vehicle_field vehicle_type, attr, f
    if dropdown_field?(vehicle_type, attr)
      render_dropdown_field vehicle_type, attr, f
    elsif file_field?(vehicle_type, attr)
      render_file_field attr, f
    else
      render_text_field attr, f
    end
  end

  def dropdown_field? vehicle_type, attr
    s = select_options[vehicle_type.to_sym] and
    s[attr.to_sym]
  end

  def file_field? vehicle_type, attr
    attr.to_sym == :poster
  end

  def render_dropdown_field vehicle_type, attr, f
    output = content_tag(:div, content_tag(:span, t("labels.project_type"), :class => 'prefix'), :class => 'large-3 small-3 columns')
    output << content_tag(:div, f.select(attr, select_options_for(vehicle_type, attr),{}, {:id => 'project-type-select'}), :class => 'large-9 small-9 columns')
    content_tag :div, output, :class => 'row collapse'
  end

  def render_text_field attr, f
    output = f.text_field attr, :placeholder => t(attr, default: attr.to_s.humanize), :class => field_classes[attr]
    output << content_tag(:span, t("units.#{attr}", :default => ''), :class => 'input-append-thing')
    output
  end

  def render_file_field attr, f
    output = f.file_field attr, :placeholder => t(attr, default: attr.to_s.humanize), :class => field_classes[attr]
    output
  end

  mattr_accessor :select_options, :specific_section_fields, :section_fields, :field_classes
  # project type helper
  self.select_options = {
    :car => {
      :project_type => ['autocross warrior', 'track attack', 'drifter', 'daily driver', 'offroader', 'hauler', 'vip']
    },
    :motorcycle => {
      :project_type => ['track attack', 'adventure', 'street fighter', 'commuter', 'stunter']
    }
  }

  # fields specific to vehicle types
  self.specific_section_fields = {
    :car => {
      :suspension => [:camber_front, :camber_rear],
      :drivetrain => [:transmission, :differential_ratio, :differential_lock],
      :wheels => [:wheel_front, :wheel_rear, :wheel_front_diameter,
                  :wheel_rear_diameter, :wheel_front_width, :wheel_rear_width],
      :interior => [:rollcage, :steering_wheel, :pedals],
      :exterior => [:bumper_front, :bumper_rear, :hood, :trunk, :tint, :spoiler]
    },
    :motorcycle => {
      :drivetrain => [:sprocket_front, :sprocket_front_diff, :sprocket_rear, :sprocket_rear_diff, :chain, :chain_pitch],
      :interior => [:control_levers, :steering_damper, :rear_sets],
      :exterior => [:crash_cage, :plastics]
    }
  }
  # fields shared by both vehicle types
  self.section_fields = {
    :overview => [:acquired_at, :project_type],
    :suspension => [:height_diff, :springs_front, :springs_rear, :dampers_front, :dampers_rear],
    :engine => [:intake, :exhaust, :engine_management, :engine_code],
    :brakes => [:brake_front_diameter, :brake_rear_diameter, :rotor_front, :rotor_rear, :caliper_front,
                :caliper_rear, :brake_front_lines, :brake_rear_lines, :brake_front_pads, :brake_rear_pads],
    :wheels => [:tire_front, :tire_rear, :tire_front_width, :tire_rear_width, :tire_front_profile, :tire_rear_profile],
    :interior => [:gauges, :seat],
    :exterior => [:headlight],
    :poster => [:poster]
  }

  # CSS classes for fields, for instance, to help datepicker element auto-instantiate
  self.field_classes = {
    :acquired_at => 'date'
  }
end
