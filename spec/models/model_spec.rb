require 'spec_helper'

describe Model do

  it 'can print the name of its vehicle_type' do
    base_vehicle = create(:base_vehicle_car).model
    base_vehicle.chassis_type.should == 'car'
  end

end
