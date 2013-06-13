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

    #it 'should returns fields for grou pand vehicle type' do
    #  Vehicle.fields_for(:motorcycle, :wheels).should == 
    #end
  end

  describe 'as instance' do
    let(:vehicle){ create(:vehicle, :profile => profile) }
    it 'should set location from profile' do 
      vehicle.location_id.should be_present
      vehicle.location_id.should == profile.location_id
    end

    it 'should set nickname from profile' do
      vehicle.nickname.should == "#{profile.username}s-#{vehicle.model.to_url}"
    end

    it 'should validate nickname presence if profile is set' do
      v = create(:vehicle)
      v.nickname.should be_nil

      v.profile = profile
      v.save

      v.nickname.should be_present
      v.nickname = ''
      v.save.should be_false
    end

    it 'should return #make_slug' do
      vehicle.make_slug.should == 'mazda'
    end

    it 'should return #model_slug' do
      vehicle.model_slug.should == 'mx-5-miata'
    end
    
    it 'should validate uniqueness of nickname within scope'
  end
end
