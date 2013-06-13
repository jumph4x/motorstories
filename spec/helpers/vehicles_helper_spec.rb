require 'spec_helper'

describe VehiclesHelper do

  context 'on #select_options_for' do
    it 'should return an array' do
      helper.select_options_for('car', :project_type).should include('drifter')
    end
  end
end
