class Location
  attr_accessor :name, :id, :slug

  def initialize attrs
    self.name = attrs[:name]
    self.id = attrs[:id]
    self.slug = attrs[:slug]
  end

  @id_map = {}
  @name_map = {}
  @slug_map = {}

  class << self
    attr_accessor :data, :id_map, :name_map, :slug_map

    def populate data
      @data = data

      data.each_with_index do |city_hash, index|
        id, name, slug = city_hash.values_at(:id, :name, :slug)

        @id_map[id] = index
        @name_map[name] = index
        @slug_map[slug] = index
      end

      true
    end

    def find_by_id id
      load_by_index(id_map[id.to_i])
    end

    def find_by_name name
      load_by_index(name_map[name])
    end

    def find_by_slug slug
      load_by_index(slug_map[slug])
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

    def pluck attrib
      raise 'No such attribute' unless [:slug, :id, :name].include? attrib.to_sym

      (send("#{attrib}_map") || {}).keys
    end
  end
end
