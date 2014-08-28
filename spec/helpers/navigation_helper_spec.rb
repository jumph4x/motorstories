require 'spec_helper'

describe NavigationHelper do
  let(:pv){ create(:proto_car) }

  context 'for MMY' do
    it 'renders Make' do
      pv
      expect(helper.make_dropdown).to match(pv.make)
    end

    it 'renders Model' do
      allow(helper).to receive_messages(:make_name => pv.make)
      pv
      expect(helper.model_dropdown).to match(pv.model)
    end

    it 'renders Year' do
      allow(helper).to receive_messages(:make_name => pv.make, :model_name => pv.model)
      pv

      expect(helper.year_dropdown).to match(pv.year.to_s)
    end
  end
end
