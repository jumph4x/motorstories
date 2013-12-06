require 'spec_helper'

describe Vehicle do
  let(:user){create(:user) }

  describe 'at class' do
    it 'should have [un]claimed scopes' do
      v = create(:vehicle, :model => 'UNCLAIMED')
      v2 = create(:vehicle, :model => 'CLAIMED', :user => user)

      Vehicle.unclaimed.all.should == [v]
      Vehicle.claimed.all.should == [v2]
    end
  end

  describe 'as instance' do
    let(:vehicle){ create(:vehicle, :user => user) }

    it 'should output #semantic_url_hash' do
      h = vehicle.semantic_url_hash
      h[:make_slug].should == vehicle.make.to_url
      h[:model_slug].should == vehicle.model.to_url
      h[:year].should == vehicle.year
      h[:nickname].should == vehicle.nickname
      h.size.should == 4
    end

    it 'should self identify as claimed?' do
      vehicle.claimed?.should be_true
      vehicle.set(:user_id => nil)
      vehicle.reload
      vehicle.claimed?.should be_false
    end

    it 'should belong to a base_vehicle' do
      v = create(:vehicle)
      v.proto_vehicle.should be_present
    end

    it 'should have a vehicle_type set' do
      v = create(:vehicle)
      v.vehicle_type.should == 'Car'
    end

    it 'should be able to print vehicle name' do
      vehicle.name.should == '2006 Mazda MX-5 Miata'
    end

    pending 'should set location from user' do 
      vehicle.location_id.should be_present
      vehicle.location_id.should == user.location_id
    end

    it 'should set nickname from user' do
      vehicle.nickname.should == "#{user.username}s-#{vehicle.model.to_url}"
    end

    it 'should validate nickname presence if user is set' do
      v = create(:vehicle)
      val1 = v.nickname

      v.user = user
      v.save

      v.nickname.should be_present
      val1.should_not == v.nickname
      v.nickname = ''
      v.save.should be_false
    end

    it 'should return #make_slug' do
      vehicle.make_slug.should == 'mazda'
    end

    it 'should return #model_slug' do
      vehicle.model_slug.should == 'mx-5-miata'
    end
    
    it 'should validate uniqueness of nickname within scope' do
      v2 = create(:vehicle, :make => 'BMW', :model => "MX-5 Miata")
      v2.nickname = 'test-nickname'
      v2.save

      vehicle.nickname = 'test-nickname'
      vehicle.should_not be_valid
    end

    context 'when tied to a base vehicle' do
      let(:proto_vehicle){ create(:proto_car) }
      let(:blank_vehicle) do
        v = Vehicle.new
        v.proto_vehicle = proto_vehicle
        v.prime!
        v
      end

      it 'gets name from base_vehicle' do
        blank_vehicle.make.should == 'Mazda'
      end
    end
  end
end
