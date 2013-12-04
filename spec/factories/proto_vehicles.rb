FactoryGirl.define do
  
  factory :proto_motorcycle, :class => ProtoVehicle do
    make 'KTM'
    model '990 SMR'
    year 2011
    vehicle_type 'Offroad Motorcycle'
  end

  factory :proto_car, :class => ProtoVehicle do
    make 'Mazda'
    model 'MX-5 Miata'
    year 2006
    vehicle_type 'Car'
  end

  factory :proto_atv, :class => ProtoVehicle do
    make 'Bombardier'
    model 'Bombardier'
    year 2000
    vehicle_type 'ATV'
  end
end

