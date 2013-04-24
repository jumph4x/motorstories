FactoryGirl.define do
  
  factory :user do
    username 'destructoid'
    name 'James'
    email 'james@gmail.com'
    password 'hehsadaaa'
    location_id {Location.first.id}
  end

end
