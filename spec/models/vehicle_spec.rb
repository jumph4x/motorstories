require 'spec_helper'

describe Vehicle do
  it 'should belong to a base_vehicle' do
    v = create(:vehicle)
    v.base_vehicle.should be_present
  end

  describe 'at class level' do
    it 'should have [un]claimed scopes' do
      u = create(:user)
      v = create(:vehicle, :model => 'UNCLAIMED')
      v2 = create(:vehicle, :model => 'CLAIMED', :user => u)

      Vehicle.unclaimed.all.should == [v]
      Vehicle.claimed.all.should == [v2]
    end
  end
end
