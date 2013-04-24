require 'spec_helper'

describe User do
  it 'should load locations by id' do
    user = FactoryGirl.create(:user)  
    user.location.name.should be_present

    user.location_id = nil
    user.save.should be_false
    user.errors.messages[:location_id].join.should match(/location/i)
    lambda{ user.save! }.should raise_error
  end
end
