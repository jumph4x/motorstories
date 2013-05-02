require 'spec_helper'

describe NavigationHelper do
  let(:bv){ create(:base_vehicle_car) }

  context 'for MMY' do
    it 'renders Make' do
      bv
      helper.make_dropdown.should contain(bv.make.name)
    end

    it 'renders Model' do
      helper.stub(:current_make).and_return(bv.make)
      bv
      helper.model_dropdown.should contain(bv.model.name)
    end

    it 'renders Year' do
      helper.stub(:current_make).and_return(bv.make)
      helper.stub(:current_model).and_return(bv.model)
      bv
      helper.year_dropdown.should contain(bv.year.to_s)
    end
  end
end
