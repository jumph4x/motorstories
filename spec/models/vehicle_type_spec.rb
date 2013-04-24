require 'spec_helper'

describe VehicleType do

  it 'should load records by id' do
    vehicle_type = VehicleType.find_by_id 5
    vehicle_type.should be_a(VehicleType)
    vehicle_type.name.should == 'car'
  end

end
