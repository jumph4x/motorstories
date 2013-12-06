FactoryGirl.define do

  factory :vehicle do
    make 'Mazda'
    model 'MX-5 Miata'
    year 2006
    proto_vehicle { create(:proto_car) }
  end
end
