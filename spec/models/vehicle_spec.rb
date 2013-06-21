require 'spec_helper'

describe Vehicle do
  let(:profile){ create(:profile) }

  describe 'at class' do
    it 'should have [un]claimed scopes' do
      v = create(:vehicle, :model => 'UNCLAIMED')
      v2 = create(:vehicle, :model => 'CLAIMED', :profile => profile)

      Vehicle.unclaimed.all.should == [v]
      Vehicle.claimed.all.should == [v2]
    end
  end

  describe 'as instance' do
    let(:vehicle){ create(:vehicle, :profile => profile) }

    it 'should belong to a base_vehicle' do
      v = create(:vehicle)
      v.base_vehicle.should be_present
    end

    it 'should have a vehicle_type set' do
      v = create(:vehicle)
      v.vehicle_type.should == 'car'
    end

    it 'should be able to print vehicle name' do
      vehicle.name.should == '2006 Mazda MX-5 Miata'
    end

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

    context 'when tied to a base vehicle' do
      let(:base_vehicle){ create(:base_vehicle_car) }
      let(:blank_vehicle) do
        v = Vehicle.new
        v.base_vehicle = base_vehicle
        v.prime!
        v
      end

      it 'gets name from base_vehicle' do
        blank_vehicle.make.should == 'Mazda'
      end
    end
  end
end
