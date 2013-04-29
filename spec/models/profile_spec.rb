require 'spec_helper'

describe Profile do
  let(:profile){ create(:profile) }

  it 'should load locations by id' do
    profile.location.name.should be_present

    profile.location_id = nil
    profile.save.should be_false
    profile.errors.messages[:location_id].join.should match(/location/i)
    lambda{ profile.save! }.should raise_error
  end

  context 'for validations' do
    it 'should require username' do
      profile.username.should be_present

      profile.username = nil
      profile.save.should be_false
      profile.errors.messages[:username].join.should match(/blank/i)
      lambda{ profile.save! }.should raise_error
    end
  end
end

