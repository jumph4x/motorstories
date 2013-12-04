class ProtoVehicle
  require 'carrierwave/orm/mongomapper'
  include MongoMapper::Document

  VEHICLE_TYPE_SCOPE = ['Car', 'Trucks', 'Offroad Motorcycle', 'Street Mootorcycle']
  scope :cars_and_motorcycles, where(:vehicle_type => VEHICLE_TYPE_SCOPE)

  key :make,          String,   :requred => true
  key :model,         String,   :requred => true
  key :year,          Integer,  :requred => true
  key :vehicle_type,  String,   :requred => true

  class << self
    def model_names_by_make make
      return [] unless make

      cars_and_motorcycles.
        where(:make => make).
        sort(:model.asc).
        only(:model).
        map(&:model).
        uniq
    end

    def make_names
      return @cached_make_names if @cached_make_names
      @cached_make_names ||= cars_and_motorcycles.
        sort(:make.asc).
        only(:make).
        map(&:make).
        uniq
    end

    def years_by_make_and_model make, model
      return [] unless make and model

      cars_and_motorcycles.
        where(:make => make, :model => model).
        sort(:year).
        only(:year).
        map(&:year).
        uniq
    end

    def all_by_mmy_slugs make_slug, model_slug, year
      query = Motorstories::SlugCache.query_hash_from_mmyn_slugs make_slug, model_slug, year, nil
      where(query)
    end
  end
end
