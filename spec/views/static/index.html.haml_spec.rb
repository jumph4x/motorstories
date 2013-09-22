require 'spec_helper'

describe 'static/index.html.haml' do
  it 'displays prominent photography' do
    render

    rendered.should have_css('#hero')
  end

  it 'gives a static tour of the product' do
    render
   
    rendered.should match('Free')
    rendered.should match('Private')
    rendered.should match('Motorcycle')
    rendered.should match('Car')
  end
end
