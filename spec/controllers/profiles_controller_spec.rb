require 'spec_helper'

describe ProfilesController do
  let(:profile){ create(:profile) }

  context 'on #show' do

    it 'should render' do
      get :show, :id => profile.username
      response.code.should == '200'
      response.should render_template(:show)
      assigns(:profile).should == profile
    end
  end

  context 'on #show' do
    it 'should render' do
      get :index
      response.code.should == '200'
      response.should render_template(:index)
    end
  end

end
