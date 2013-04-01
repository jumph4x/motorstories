require 'spec_helper'

describe 'static/index.html.haml' do
  it 'displays prominent photography' do
    render

    rendered.should have_css('#hero')
  end

  it 'gives a static tour of the product' do
    render
   
    rendered.should match /free/i
    rendered.should match /private/i
    rendered.should match /motorcycle/i
    rendered.should match /car/i
    rendered.should match /suspension/i
    rendered.should match /engine/i
    rendered.should match /wheel fitment/i
  end
end
