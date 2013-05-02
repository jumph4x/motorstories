require 'spec_helper'

describe VehiclesController do
  let(:profile){ create(:profile) }
  let(:vehicle){ create(:vehicle, :profile => profile) }
  let(:location){ Location.first }

  before do
    Motorstories::Application.reload_routes!
    Make.clear_cache
    controller.extend NavigationHelper
  end

  def request_params loc, veh, extended = false
    hash =
    {
      :location_slug => loc.slug,
      :make_slug=> veh.make_slug,
      :model_slug=> veh.model_slug,
      :trailing_slash => true
    }

    if extended
      hash[:year] = veh.year
      hash[:nickname] = veh.nickname
      hash.delete(:trailing_slash)
    end

    hash
  end

  context 'on #index' do
    it 'should prep the environment' do 
      get :index, request_params(location, vehicle)
      response.should render_template(:index)

      assigns(:location).should be_a(Location)

      assigns(:make).should be_a(Make)
      assigns(:model).should be_a(Model)

      assigns(:vehicles).should == [vehicle]
    end
  end

  context 'on #show' do
    it 'should prep the environment' do 
      get :show, request_params(location, vehicle, true)
      response.should render_template(:show)

      assigns(:location).should be_a(Location)

      assigns(:make).should be_a(Make)
      assigns(:model).should be_a(Model)

      assigns(:vehicle).should == vehicle
    end
  end
end
