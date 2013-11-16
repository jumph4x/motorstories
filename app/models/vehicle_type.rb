class VehicleType
  attr_accessor :name, :id

  def initialize attrs
    self.id = attrs[:id]
    self.name = attrs[:name]
  end

  class << self
    attr_accessor :data

    def find_by_id id
      VehicleType.new self.data[id.to_i]
    end

    def seed!
      self.data = {
        4 => {:id => 4, :name => 'car'},
        5 => {:id => 5, :name => 'car', :desc => 'Car'},
        6 => {:id => 6, :name => 'car', :desc => 'Truck'},
        7 => {:id => 7, :name => 'car', :desc => 'Van'},
        40 => {:id => 40, :name => 'motorcycle'},
        46 => {:id => 46, :name => 'motorcycle', :desc => 'Offroad motorcycle'},
        49 => {:id => 49, :name => 'motorcycle', :desc => 'Street motorcycle'},
        2189 => {:id => 2189, :name => 'motorcycle', :desc => 'Scooter'},
        2201 => {:id => 2201, :name => 'motorcycle', :desc => 'Scooter'}
      }
    end
  end

end
