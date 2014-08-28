require 'spec_helper'

module Motorstories
  describe SlugCache do
    let(:singleton){ SlugCache }

    let(:moto){ create(:proto_motorcycle) }
    let(:car){ create(:proto_car) }
    let(:atv){ create(:proto_atv) }

    context '::make_query' do
      it 'returns the full make name' do
        expect(singleton.make_query(car.make.to_url)).to eq('Mazda')
      end
    end
  end
end
