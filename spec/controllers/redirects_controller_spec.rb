require 'spec_helper'

describe RedirectsController do
  before{ Motorstories::Application.reload_routes! }
  let(:bv){ create(:base_vehicle_car) }

  context 'on #vehicles_index' do
    it 'should redirect' do
      get :vehicles_index,
        :make_slug => bv.make.name.to_url, 
        :model_slug => bv.model.name.to_url,
        :year => bv.year
      response.should be_redirect
    end
  end
end

