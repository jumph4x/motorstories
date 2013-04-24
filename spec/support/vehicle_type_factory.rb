module VehicleTypeFactory
  def self.included(base)
    base.class_eval do
      # Run automatically on each controller spec case
      before(:all){ load_dummy_vehicle_types } 
    end
  end

  def load_dummy_vehicle_types
    vehicle_types = {}
    vehicle_types[5] = {:id => 5, :name => 'car'}
    VehicleType.data = vehicle_types
  end

  def remove_dummy_vehicle_types
    VehicleType.data = nil
  end
end
