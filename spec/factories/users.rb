FactoryGirl.define do
  
  factory :user do
    name 'James'
    email 'james@gmail.com'
    password 'hehsadaaa'
    username 'loluser'
    location_id {Location.first.id}
  end

end
