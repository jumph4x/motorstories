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
        5 => {:id => 5, :name => 'car'},
        6 => {:id => 6, :name => 'car'},
        7 => {:id => 7, :name => 'car'},
        40 => {:id => 40, :name => 'motorcycle'}
      }
    end
  end

end
