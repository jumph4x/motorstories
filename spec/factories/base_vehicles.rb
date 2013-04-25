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

  factory :base_vehicle_atv, :class => BaseVehicle do
    make { create(:make, :name => 'Yamaha' )}
    model { create(:model, :name => 'Explorer',:vehicle_type_id => 39) }
    year 2005
  end

  factory :base_vehicle_ktm_atv, :class => BaseVehicle do
    make { create(:make, :name => 'KTM') } 
    model { create(:model, :name => 'Fake ATV', :vehicle_type_id => 39) }
    year 2011
  end
end
