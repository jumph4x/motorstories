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
  end

end
