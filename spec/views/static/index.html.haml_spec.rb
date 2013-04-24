require 'spec_helper'

describe 'static/index.html.haml' do
  it 'displays prominent photography' do
    render

    rendered.should have_css('#hero')
  end

  it 'gives a static tour of the product' do
    render
   
    rendered.should contain('Free')
    rendered.should contain('Private')
    rendered.should contain('Motorcycle')
    rendered.should contain('Car')
    rendered.should contain('Suspension')
    rendered.should contain('Engine')
    rendered.should contain('Wheel fitment')
  end
end
