require 'spec_helper'

describe Devise::SessionsController do
  render_views
  before{ @request.env["devise.mapping"] = Devise.mappings[:user] }

  it 'renders #new' do
    get :new
    expect(response).to render_template(:new)
    expect(response.code).to eq('200')
  end
end

