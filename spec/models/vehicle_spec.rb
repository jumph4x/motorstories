require 'spec_helper'

describe Vehicle do
  let(:profile){ create(:profile) }
  it 'should belong to a base_vehicle' do
    v = create(:vehicle)
    v.base_vehicle.should be_present
  end

  describe 'at class' do
    it 'should have [un]claimed scopes' do
      v = create(:vehicle, :model => 'UNCLAIMED')
      v2 = create(:vehicle, :model => 'CLAIMED', :profile => profile)

      Vehicle.unclaimed.all.should == [v]
      Vehicle.claimed.all.should == [v2]
    end
  end

  describe 'as instance' do
    it 'should set location from profile' do
      v = create(:vehicle, :profile => profile) 
      v.location_id.should be_present
      v.location_id.should == profile.location_id
    end
  end
end
