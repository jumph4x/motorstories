require 'spec_helper'

describe Make do

  context 'at class level' do
    it 'has an auto-moto scope' do
      car = create(:base_vehicle_car)
      moto = create(:base_vehicle_moto)
      atv = create(:base_vehicle_atv)

      Make.car_or_motorcycle.all.map(&:name).should == ['Mazda', 'KTM'] 
    end
  end
end
