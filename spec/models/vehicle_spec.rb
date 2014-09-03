require 'spec_helper'

describe Vehicle do
  let(:user){create(:user) }

  describe 'at class' do
    it 'should have [un]claimed scopes' do
      v = create(:vehicle, :model => 'UNCLAIMED')
      v2 = create(:vehicle, :model => 'CLAIMED', :user => user)

      expect(Vehicle.unclaimed.all).to eq([v])
      expect(Vehicle.claimed.all).to eq([v2])
    end
  end

  describe 'as instance' do
    let(:vehicle){ create(:vehicle, :user => user) }

    it 'should output #semantic_url_hash' do
      h = vehicle.semantic_url_hash
      expect(h[:make_slug]).to eq(vehicle.make.to_url)
      expect(h[:model_slug]).to eq(vehicle.model.to_url)
      expect(h[:year]).to eq(vehicle.year)
      expect(h[:nickname]).to eq(vehicle.nickname)
      expect(h.size).to eq(4)
    end

    it 'should self identify as claimed?' do
      expect(vehicle.claimed?).to be_truthy
      vehicle.set(:user_id => nil)
      vehicle.reload
      expect(vehicle.claimed?).to be_falsey
    end

    it 'should belong to a base_vehicle' do
      v = create(:vehicle)
      expect(v.proto_vehicle).to be_present
    end

    it 'should have a vehicle_type set' do
      v = create(:vehicle)
      expect(v.vehicle_type).to eq('Car')
    end

    it 'should be able to print vehicle name' do
      expect(vehicle.name).to eq('2006 Mazda MX-5 Miata')
    end

    it 'should set nickname from user' do
      expect(vehicle.nickname).to eq("#{user.username}s-#{vehicle.model.to_url}")
    end

    it 'should validate nickname presence if user is set' do
      v = create(:vehicle)
      val1 = v.nickname

      v.user = user
      v.save

      expect(v.nickname).to be_present
      expect(val1).to eq(v.nickname)
      v.nickname = ''
      expect(v.save).to be_falsey
    end

    it 'should return #make_slug' do
      expect(vehicle.make_slug).to eq('mazda')
    end

    it 'should return #model_slug' do
      expect(vehicle.model_slug).to eq('mx-5-miata')
    end

    it 'should validate uniqueness of nickname within scope' do
      v2 = create(:vehicle, :make => 'BMW', :model => "MX-5 Miata")
      v2.nickname = 'test-nickname'
      v2.save

      vehicle.nickname = 'test-nickname'
      expect(vehicle).not_to be_valid
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
        expect(blank_vehicle.make).to eq('Mazda')
      end
    end

    context 'when modded' do
      it 'primes story entries' do
        expect(vehicle.entries).to be_empty
        vehicle.motor_modded = '1'
        vehicle.suspension_modded = '1'
        vehicle.brakes_modded = '0'
        vehicle.save

        expect(vehicle.entries.size).to eq(2)
      end
    end
  end
end
