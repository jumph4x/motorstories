require 'spec_helper'

describe User do
  it 'should load locations by id' do
    user = FactoryGirl.create(:user)  
    user.location_id = 4321
    user.location.name.should == 'Dummy Location'
  end
end
