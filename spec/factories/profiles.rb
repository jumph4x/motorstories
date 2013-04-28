FactoryGirl.define do
  
  factory :profile do
    username 'destructoid'
    location_id {Location.first.id}
  end

end

