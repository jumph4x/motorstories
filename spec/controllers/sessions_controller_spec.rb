require 'spec_helper'

describe Devise::SessionsController do
  render_views
  before{ @request.env["devise.mapping"] = Devise.mappings[:user] }

  it 'renders #new' do
    get :new
    response.should render_template(:new)
    response.code.should == '200'
  end
end

