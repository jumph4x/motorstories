require 'spec_helper'

describe Model do

  it 'can print the name of its vehicle_type' do
    base_vehicle = create(:base_vehicle_car).model
    base_vehicle.chassis_type.should == 'car'
  end

  context 'at class level' do
    it 'finds all models by make' do
      moto = create(:base_vehicle_moto)
      ktm_atv = create(:base_vehicle_ktm_atv)

      Model.by_make_id(moto.make_id).map(&:name).should == ['690 SMC']
    end 
  end

end
