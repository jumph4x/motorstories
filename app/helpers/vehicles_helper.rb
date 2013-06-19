module VehiclesHelper

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
end
