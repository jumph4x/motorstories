class Location
  attr_accessor :name, :id

  def initialize attrs
    self.name = attrs[:name]
    self.id = attrs[:id]
  end

  class << self
    attr_reader :data, :id_map, :name_map
    
    def populate data
      @id_map = {}
      @name_map = {}
      @data = data

      data.each_with_index do |city_hash, index|
        id, name = city_hash[:id], city_hash[:name]

        @id_map[id] = index
        @name_map[name] = index
      end

      true
    end

    def find_by_id id
      load_by_index(id_map[id.to_i])
    end

    def find_by_name name
      load_by_index(name_map[name])
    end

    def load_by_index i
      Location.new(self.data[i])
    end

    def first
      Location.new self.data.first
    end

    def last
      Location.new self.data.last
    end
  end
end
