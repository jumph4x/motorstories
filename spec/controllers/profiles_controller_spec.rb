require 'spec_helper'

describe ProfilesController do

  context 'on #show' do
    let(:profile){ create(:profile) }

    it 'should render' do
      get :show, :id => profile.username
      response.code.should == '200'
      response.should render_template(:show)
    end
  end

end
