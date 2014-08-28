require 'spec_helper'

describe User do
  let(:user){create(:user) }

  describe 'factory'  do
    it 'works' do
      expect(user).to be_truthy
    end
  end
end
