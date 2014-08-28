include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :vehicle do
    make 'Mazda'
    model 'MX-5 Miata'
    year 2006
    proto_vehicle { create(:proto_car) }
    cover{ fixture_file_upload("spec/fixtures/example.jpg", "image/jpeg") }
  end
end
