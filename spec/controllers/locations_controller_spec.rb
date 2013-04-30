require 'spec_helper'

describe LocationsController do
  let(:location){ Location.first }

  before do
    Motorstories::Application.reload_routes!
  end

  context 'on #show' do
    it 'should prep the environment' do
      get :show, :location_slug => location.slug

      response.should render_template(:show)
      assigns(:location).should be_a(Location)
    end
  end
end
