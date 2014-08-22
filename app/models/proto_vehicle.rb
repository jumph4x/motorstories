class ProtoVehicle
  require 'carrierwave/orm/mongomapper'
  include MongoMapper::Document

  VEHICLE_TYPE_SCOPE = ['Car', 'Trucks', 'Van', 'Offroad Motorcycle', 'Street Motorcycle']
  scope :cars_and_motorcycles, where(:vehicle_type => VEHICLE_TYPE_SCOPE)

  key :make,          String,   :requred => true
  key :model,         String,   :requred => true
  key :year,          Integer,  :requred => true
  key :vehicle_type,  String,   :requred => true

  class << self
    def distinct_collection field, addtl_conds = {}
      conditions = {:vehicle_type => {'$in' => ProtoVehicle::VEHICLE_TYPE_SCOPE}}
      conditions.merge!(addtl_conds)
      ProtoVehicle.collection.distinct(field, conditions)
    end

    def model_names_by_make make
      return [] unless make

      distinct_collection(:model, {:make => make}).sort
    end

    def make_names
      return @cached_make_names if @cached_make_names
      @cached_make_names ||= distinct_collection(:make).sort

    end

    def years_by_make_and_model make, model
      return [] unless make and model

      distinct_collection(:year, {:make => make, :model => model}).sort{|a,b| b <=> a }
    end

    def all_by_mmy_slugs make_slug, model_slug, year
      query = Motorstories::SlugCache.query_hash_from_mmyn_slugs make_slug, model_slug, year, nil
      where(query)
    end
  end
end
