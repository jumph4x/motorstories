require 'spec_helper'

describe ProtoVehicle do
  let(:moto){ create(:proto_motorcycle) }
  let(:car){ create(:proto_car) }
  let(:atv){ create(:proto_atv) }

  context 'on queries' do
    it 'scopes to only cars and motorcycles' do
      moto && car && atv
      expect(ProtoVehicle.cars_and_motorcycles.all.map(&:make)).to eq(['KTM', 'Mazda'])
    end
  end
end
