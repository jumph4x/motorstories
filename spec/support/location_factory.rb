module LocationFactory
  def self.included(base)
    base.class_eval do
      # Run automatically on each controller spec case
      before(:all){ load_dummy_locations } 
    end
  end

  def load_dummy_locations
    locations = [
      {:id => 4321, :name => 'Dummy Location', :slug => 'dummy-location'},
      {:id => 66, :name => 'Another Location', :slug => 'another-location'}
    ]
    Location.populate locations
  end
end
