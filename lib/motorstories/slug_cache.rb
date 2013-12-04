module Motorstories
  class SlugCache
    class << self
      attr_accessor :make_map, :model_map

      def ensure_initialized!
        return if make_map.present? and model_map.present?

        [:make, :model].each do |typ|
          collection = ProtoVehicle.collection.distinct(typ, {:vehicle_type => {'$in' => ProtoVehicle::VEHICLE_TYPE_SCOPE}})
          map_collection collection, typ
        end  
      end

      def map_collection values, typ
        self.send("#{typ}_map=", {})

        values.each do |value|
          self.send("#{typ}_map")[value.to_url] = value
        end
      end

      def query slug, typ
        return unless slug
        ensure_initialized!

        self.send("#{typ}_map")[slug]
      end

      def make_query slug
        query(slug, :make)
      end

      def model_query slug
        query(slug, :model)
      end

      def query_hash_from_mmyn_slugs make_slug, model_slug, year, nickname
        {
          make: make_query(make_slug),
          model: model_query(model_slug),
          year: year.try(:to_i),
          nickname: nickname
        }.keep_if do |key, value|
          value
        end
      end
    end
  end
end

