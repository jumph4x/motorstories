require 'spec_helper'

describe Profile do
  it 'should load locations by id' do
    profile = FactoryGirl.create(:profile)  
    profile.location.name.should be_present

    profile.location_id = nil
    profile.save.should be_false
    profile.errors.messages[:location_id].join.should match(/location/i)
    lambda{ profile.save! }.should raise_error
  end
end

