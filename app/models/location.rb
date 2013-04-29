class Location
  attr_accessor :name, :id

  def initialize attrs
    self.name = attrs[:name]
    self.id = attrs[:id]
  end

  class << self
    attr_accessor :data

    def find_by_id id
      Location.new(self.data[id.to_i])
    end

    def first
      Location.new self.data.first.last
    end

    def last
      Location.new self.data.to_a.last.last
    end
  end
end
