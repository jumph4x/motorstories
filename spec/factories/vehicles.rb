FactoryGirl.define do

  factory :vehicle do
    make 'Miata'
    model 'MX-5 Miata'
    year 2006
    base_vehicle { create(:base_vehicle_car) }
  end
end
