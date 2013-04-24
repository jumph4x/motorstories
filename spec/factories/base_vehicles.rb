FactoryGirl.define do
  
  factory :base_vehicle_moto, :class => BaseVehicle do
    make { create(:make, :name => 'KTM') } 
    model { create(:model, :name => '690 SMC', :vehicle_type_id => 40) }
    year 2008
  end

  factory :base_vehicle_car, :class => BaseVehicle do
    make { create(:make, :name => 'Mazda' )}
    model { create(:model, :name => 'MX-5 Miata', :vehicle_type_id => 5) }
    year 2006
  end

end

