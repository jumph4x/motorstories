require 'spec_helper'

describe YearsController do

  let(:bv){ create(:base_vehicle_car) }
  before{ Make.clear_cache }

  context 'on #index' do
    it 'should respond to JSON' do
      get :index,
        :make_slug => bv.make.name.to_url,
        :model_slug => bv.model.name.to_url,
        :format => :json
      response.status.should == 200
      response.body.should match(bv.year.to_s)
    end
  end
end
