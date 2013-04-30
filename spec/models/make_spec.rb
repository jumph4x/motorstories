require 'spec_helper'

describe Make do

  context 'at class level' do
    it 'has an auto-moto scope' do
      car = create(:base_vehicle_car)
      moto = create(:base_vehicle_moto)
      atv = create(:base_vehicle_atv)

      Make.car_or_motorcycle(true).map(&:name).should == ['KTM', 'Mazda'] 
    end

    it 'has an in-memory slug lookup cache' do
      moto = create(:base_vehicle_moto)
      
      Make.find_by_slug('ktm').name.should == 'KTM' 
    end

  end
end
