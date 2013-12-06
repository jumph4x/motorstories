require 'spec_helper'

describe VehiclesController do
  render_views

  let(:user){ create(:user) }
  let(:vehicle){ create(:vehicle, :user => user) }

  before do
    Motorstories::Application.reload_routes!
    Make.clear_cache
    controller.extend NavigationHelper
  end

  def request_params veh, extended = false
    hash =
    {
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
      get :index, request_params(vehicle)

      assigns(:vehicles).should == [vehicle]
    end

    it 'should render' do
      get :index, request_params(vehicle)
      response.should render_template(:index)
    end
  end

  context 'on #show' do
    it 'should prep the environment' do 
      get :show, request_params(vehicle, true)

      assigns(:vehicle).should == vehicle
    end

    it 'should render' do
      get :show, request_params(vehicle, true)
      response.should render_template(:show)
    end
  end

  context 'on #new' do
    context 'without proper parameters' do
      it 'should redirect' do
        get :new
        response.should redirect_to '/'
      end
    end

    context 'with proper parameters' do
      let(:pv){ create(:proto_car) }
      it 'should render' do
        get :new, {
          make_slug: pv.make.to_url,
          model_slug: pv.model.to_url,
          year: pv.year
        }
        response.should render_template(:new)
      end
    end
  end

  context 'on #edit' do
    context 'when logged in' do
      before do
        sign_in user
      end

      context 'when adding a poster' do
        it 'should render' do
          get :edit, :id => vehicle.id, :segment => :poster
          response.should render_template(:edit)
        end
      end
    end
  end
end
