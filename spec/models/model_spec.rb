require 'spec_helper'

describe Model do

  it 'can print the name of its vehicle_type' do
    car = create(:base_vehicle_car).model
    moto = create(:base_vehicle_moto).model
    car.vehicle_type.should == 'car'
    moto.vehicle_type.should == 'motorcycle'
  end

end
