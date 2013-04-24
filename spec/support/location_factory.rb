module LocationFactory
  def self.included(base)
    base.class_eval do
      # Run automatically on each controller spec case
      before(:all){ load_dummy_data } 
    end
  end

  def load_dummy_data
    locations = {}
    locations[4321] = {:id => 4321, :name => 'Dummy Location'}
    Location.data = locations
  end

  def remove_dummy_data
    Location.data = nil
  end
end