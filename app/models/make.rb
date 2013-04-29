class Make
  include MongoMapper::Document

  has_many :base_vehicles

  key :name, String

  class << self
    attr_accessor :car_moto_makes, :slug_map

    def car_or_motorcycle refresh = false
      self.car_moto_makes = nil if refresh

      return car_moto_makes if car_moto_makes.present?

      model_ids = Model.car_or_motorcycle.distinct(:_id)
      make_ids = BaseVehicle.where(:model_id => model_ids).distinct(:make_id)
      
      self.car_moto_makes = all(:_id => make_ids, :sort => :name.asc)
    end

    def initialize_slug_cache
      return true if slug_map

      @slug_map = {}
      car_or_motorcycle.each_with_index do |make, index|
        @slug_map[make.name.to_url] = index
      end

      true
    end

    def find_by_slug slug
      initialize_slug_cache
      car_or_motorcycle[slug_map[slug]] 
    end
  end
end
