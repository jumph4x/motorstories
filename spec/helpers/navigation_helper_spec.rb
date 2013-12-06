require 'spec_helper'

describe NavigationHelper do
  let(:pv){ create(:proto_car) }

  context 'for MMY' do
    it 'renders Make' do
      pv
      helper.make_dropdown.should match(pv.make)
    end

    it 'renders Model' do
      helper.stub(:make_name).and_return(pv.make)
      pv
      helper.model_dropdown.should match(pv.model)
    end

    it 'renders Year' do
      helper.stub(:make_name).and_return(pv.make)
      helper.stub(:model_name).and_return(pv.model)
      pv
      helper.year_dropdown.should match(pv.year.to_s)
    end
  end
end
