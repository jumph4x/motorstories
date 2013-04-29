require 'spec_helper'

describe Location do
  
  context 'as class' do
    it 'should create instance from hashes' do
      attr_hash = {:id => 1234, :name => 'New Location'}
      location = Location.new(attr_hash)
      location.should be_a(Location)
      location.name.should == 'New Location'
    end

    it 'should load records by id' do
      location = Location.find_by_id(4321)
      location.should be_a(Location)
      location.name.should == 'Dummy Location'
    end

    it 'should load records by name' do
      location = Location.find_by_name('Dummy Location')
      location.id.should == 4321
    end

    it 'should load records by name' do
      location = Location.find_by_slug('dummy-location')
      location.id.should == 4321
    end

    it 'should pluck attributes' do
      Location.pluck(:slug).should == ['dummy-location', 'another-location']
    end

    it 'should have a row counter method' do
      Location.count.should == 2
    end
  end

end
