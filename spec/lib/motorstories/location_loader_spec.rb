require 'spec_helper'

module Motorstories
  describe LocationLoader do

    it 'should be autoloaded' do
      should_not be_nil
    end

    it 'should iterate over CL cities and form an active_hash' do
      subject.location_hashes.first.should be_a(Hash)
    end

    it 'should populate location model with data' do
      subject.populate_locations
      Location.count.should > 0
    end

    context 'when working with city names' do
      it 'should hash names to numeric values without collisions' do
        hash_val = subject.hash_name('San Francisco')
        hash_val.should be_integer
      end

      it 'should decorate names to respect state abbreviations' do
        subject.decorate_name('eastern_ct').should == 'Eastern CT'
      end
    end

    context 'at class level' do
      let(:clazz){ LocationLoader }

      it 'should keep a local cache of a simple alpha -> digit cipher' do
        clazz.cipher_data['a'].should == clazz.cipher_data['A'] 
        clazz.cipher_data['b'].should == 1
        clazz.cipher_data['c'].should_not == clazz.cipher_data['a']
      end
    end
  end
end
