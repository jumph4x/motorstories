module VehiclesHelper

  SELECT_OPTIONS = {
    :car => {
      :project_type => ['autocross warrior', 'track attack', 'drifter', 'daily driver', 'offroader', 'hauler', 'vip']
    },
    :motorcycle => {
      :project_type => ['track attack', 'adventure', 'street fighter', 'commuter', 'stunter']
    }
  }
  def select_options_for vehicle_type, field
    SELECT_OPTIONS[vehicle_type.to_sym][field.to_sym]
  end
end
