require 'spec_helper'

describe VehiclesHelper do

  context 'on #select_options_for' do
    it 'should return an array' do
      helper.select_options_for('car', :project_type).should have_css('option[value="drifter"]')
    end

    context 'on provided existing value' do
      it 'should have that value pre-selected' do
        helper.select_options_for('car', :project_type, 'hauler').should have_css('option[selected="selected"]')
      end
    end
  end
end
