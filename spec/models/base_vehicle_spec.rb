require 'spec_helper'

describe BaseVehicle do

  let(:bv){ create(:base_vehicle_car) }
  context 'at class' do
    it 'should find years by make and model' do
      output = BaseVehicle.years_by_make_id_and_model_id(bv.make_id, bv.model_id)
      output.should include(2006)
    end
  end

  context 'at instance' do
    it 'should determine vehicle_type' do
      bv.vehicle_type.should == 'car'
    end
  end
end
